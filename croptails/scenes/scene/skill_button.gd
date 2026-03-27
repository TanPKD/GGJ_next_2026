extends HBoxContainer

# @onready 表示在游戏场景加载完毕的那一瞬间，去抓取这些子节点，方便后面修改它们
@onready var texture_button = $TextureButton
@onready var panel = $TextureButton/Panel
@onready var label = $MarginContainer/Label 

# --- 以下 @export 变量都会暴露在 Godot 编辑器的右侧面板中，方便你为每个节点单独设置 ---

@export_category("UI 设置")
@export var tech_icon: Texture2D              # 存放你在编辑器里拖进来的科技图标
@export_multiline var tech_description: String = "请输入科技描述..." # 存放科技的文字描述

@export_category("视觉设置 - 连线")
@export var connections_layer: Node           # 存放专门用来画线的那个 Control 节点
@export var locked_line_color: Color = Color(0.5, 0.5, 0.5, 1.0)   # 锁定时的灰线
@export var unlocked_line_color: Color = Color(0.0, 1.0, 1.0, 1.0) # 解锁时的青线
@export var line_width: float = 3.0           # 线条粗细

@export_category("逻辑设置")
@export var parent_tech_node: HBoxContainer   # 存放这个科技的“爸爸”（前置科技节点）
@export var required_global_condition: String = "" # 额外条件：比如填 "found_key_item"
@export var unlock_variable_name: String = ""      # 自己解锁后，存入全局字典的名字，比如 "tech_fire"

# 内部变量，用来记住自己当前是不是已经解锁了
var is_unlocked: bool = false
# 内部变量，用来记住自己和“爸爸”之间的那条线，方便以后改颜色
var my_line_to_parent: Line2D

# _ready() 会在游戏刚刚运行，这个节点被生出来的时候执行一次
func _ready() -> void:
	# 1. 把你在编辑器里设置的图片和文字，真正应用到UI节点上
	if tech_icon != null:
		texture_button.texture_normal = tech_icon
	if label != null:
		label.text = tech_description
		
	# 2. 问问全局数据库：“我以前是不是已经被解锁过了？”（常用于读取存档后）
	if unlock_variable_name != "" and TechManager.check_condition(unlock_variable_name):
		is_unlocked = true
		apply_unlock_visuals(false) # 直接变成解锁的样子，不播动画
	else:
		panel.show_behind_parent = false # 如果没解锁，确保高亮面板藏起来

	# 3. 开始画自己和前置科技之间的连线
	_create_connecting_line()

# 辅助函数：用来精准获取按钮的屏幕中心坐标
func get_button_center_global() -> Vector2:
	return texture_button.global_position + texture_button.size / 2

# 画线逻辑
func _create_connecting_line() -> void:
	# 如果自己是最初始的科技（没有爸爸），或者你忘了设置画线层，就不画线
	if parent_tech_node == null or connections_layer == null: return
	
	# 用代码生成一条线
	my_line_to_parent = Line2D.new()
	my_line_to_parent.width = line_width
	my_line_to_parent.z_index = -1 # 【关键】设置为 -1，保证线永远在按钮们的屁股后面，不挡视线
	
	# 把线放到我们指定的专门画线的节点里面
	connections_layer.add_child(my_line_to_parent)
	
	# 根据自己目前的解锁状态，决定线一开始是灰色还是青色
	if is_unlocked:
		my_line_to_parent.default_color = unlocked_line_color
	else:
		my_line_to_parent.default_color = locked_line_color
		
	# 【坐标转换】：因为线放在 ConnectionsLayer 里，所以必须把按钮的世界坐标，
	# 转换成相对于 ConnectionsLayer 的本地坐标，线才能精确连在按钮中心。
	var start_global = parent_tech_node.get_button_center_global()
	var start_local = connections_layer.make_canvas_position_local(start_global)
	
	var end_global = get_button_center_global()
	var end_local = connections_layer.make_canvas_position_local(end_global)
	
	# 把算好的两点加到线里，线就画出来了
	my_line_to_parent.add_point(start_local)
	my_line_to_parent.add_point(end_local)

# 单纯用来把线变色的函数
func update_line_color_to_unlocked() -> void:
	if my_line_to_parent != null:
		my_line_to_parent.default_color = unlocked_line_color

# 当玩家的鼠标点下这个科技按钮时，触发这个函数
func _on_texture_button_pressed() -> void:
	# 拦路虎1：如果已经解锁了，直接结束，什么都不做
	if is_unlocked:
		print("该科技已解锁！")
		return

	# 拦路虎2：如果有前置科技，并且前置科技还没解锁，拒绝！
	if parent_tech_node != null and not parent_tech_node.is_unlocked:
		print("前置科技尚未解锁，无法点击此科技！")
		return

	# 拦路虎3：去问全局数据库，有没有满足额外条件（比如某道具）。不满足，拒绝！
	if not TechManager.check_condition(required_global_condition):
		print("未满足全局条件：" + required_global_condition)
		return

	# 三只拦路虎都过了，说明条件全满足，执行解锁！
	execute_unlock()

# 执行解锁动作
func execute_unlock() -> void:
	# 1. 告诉全局数据库：“我解锁啦，把我的名字登记上去！”
	TechManager.activate_tech(unlock_variable_name)
	# 2. 记住自己当前的状态是已解锁
	is_unlocked = true
	# 3. 改变外观（面板高亮、线条变色）
	apply_unlock_visuals()

# 改变外观的函数
func apply_unlock_visuals(animate: bool = true) -> void:
	# 让高亮面板显示出来（这里利用了 show_behind_parent=true 的机制）
	panel.show_behind_parent = true
	# 调用上面的函数，把连着爸爸的线变成青色
	update_line_color_to_unlocked()
	
	if animate:
		print(unlock_variable_name + " 解锁成功！")
