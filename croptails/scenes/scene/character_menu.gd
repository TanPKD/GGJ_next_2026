'''
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_day_pressed() -> void:
	const DEFAULT_SCENE_PATH := "res://scenes/test/test_scene_objects_trees.tscn"
	Scene_Manager.change_scene(DEFAULT_SCENE_PATH)
'''
extends Control

@export var button_sound: AudioStreamPlayer

# ===== 三组变量（可被其他场景读取）=====
# 【三组选择结果变量】
# 用来记录每一组当前选中的职业（hunter / farmer / builder）
# 如果为空字符串 ""，说明该组当前没有选中任何按钮
# 👉 如果你用了 AutoLoad（GameData），这里可以删掉改用全局变量
#
# 真人本人： 这里我已经设置了叫做CharactersChosen，
# 来自"res://scripts/globals/characters_chosen.gd"的全局变量，
# 所以这个就没用了（但留着，保留思路）
var group1_choice: String = ""
var group2_choice: String = ""
var group3_choice: String = ""

# ===== 按钮引用 =====
# 【按钮引用表】
# groups 是一个“嵌套字典”结构：
# 外层：组编号（1 / 2 / 3）
# 内层：职业名称 → 对应按钮节点
#
# 作用：
# 👉 通过 group_id + role 可以快速找到任意按钮
# 👉 避免写一堆 $Group1/Hunter1 这种重复代码
@onready var groups = {
	1: {
		"hunter": $HBoxContainer/Panel/Panel/HBoxContainer/hunter1,
		"farmer": $HBoxContainer/Panel/Panel/HBoxContainer/farmer1,
		"builder": $HBoxContainer/Panel/Panel/HBoxContainer/builder1
	},
	2: {
		"hunter": $HBoxContainer/Panel2/Panel/HBoxContainer/hunter2,
		"farmer": $HBoxContainer/Panel2/Panel/HBoxContainer/farmer2,
		"builder": $HBoxContainer/Panel2/Panel/HBoxContainer/builder2
	},
	3: {
		"hunter": $HBoxContainer/Panel3/Panel/HBoxContainer/hunter3,
		"farmer": $HBoxContainer/Panel3/Panel/HBoxContainer/farmer3,
		"builder": $HBoxContainer/Panel3/Panel/HBoxContainer/builder3
	}
}

# 【进入下一场景按钮】
# 初始为 disabled，只有当三组都选完才解锁
@onready var next_button: Button = $Button


# ===== 初始化 =====
func _ready():
	# 初始状态：禁止进入下一场景
	next_button.disabled = true
	
	# 绑定信号：
	# 给所有按钮绑定“点击事件”
	#
	# bind(group_id, role) 的作用：
	# 👉 把“按钮属于哪一组、是什么职业”一起传进去
	# 👉 避免写 9 个不同函数
	for group_id in groups:
		for role in groups[group_id]:
			var btn = groups[group_id][role]
			# 当按钮被按下时，调用 _on_role_pressed
			btn.pressed.connect(_on_role_pressed.bind(group_id, role))


# ===== 按钮点击逻辑 =====
# 【按钮点击核心逻辑】
#
# 参数说明：
# group_id → 当前点击的是第几组（1 / 2 / 3）
# role     → 当前点击的职业（hunter / farmer / builder）
func _on_role_pressed(group_id: int, role: String):
	button_sound.play()
	# ① 取消“其他组”中相同职业的选中状态
	#
	# 规则：
	# 👉 同一个职业（例如 hunter）不能被多个组选中
	for other_group_id in groups:
		if other_group_id != group_id:
			var other_btn = groups[other_group_id][role]
			
			if other_btn.disabled:
				other_btn.disabled = false
				_set_group_choice(other_group_id, "")

	# ② 当前组：先全部恢复（清除旧选择）
	#
	# 作用：
	# 👉 确保一组里只能有一个按钮被选中
	for r in groups[group_id]:
		groups[group_id][r].disabled = false

	# ③ 将当前点击按钮设为“选中状态”
	#
	# 这里用 disabled = true 表示“被选中”
	# （相当于锁住按钮，防止重复点击）
	groups[group_id][role].disabled = true

	# ④ 更新该组的选择结果变量
	# 4️⃣ 设置变量
	_set_group_choice(group_id, role)

	# ⑤ 检查是否所有组都已完成选择
	# 5️⃣ 检查是否全部选完
	# 如果是 → 解锁“下一场景按钮”
	_check_all_selected()


# ===== 设置变量 =====
# 【设置组选择结果】
#
# 参数：
# group_id → 第几组
# value    → 选中的职业（或 "" 表示清空）
#
# 作用：
# 👉 统一管理变量修改（避免代码重复）
func _set_group_choice(group_id: int, value: String):
	match group_id:
		1:
			CharactersChosen.group1_choice = value
		2:
			CharactersChosen.group2_choice = value
		3:
			CharactersChosen.group3_choice = value


# ===== 检查是否可以进入下一场景 =====
# 【检查是否全部选择完成】
#
# 条件：
# 👉 三个组的变量都不为空
#
# 结果：
# 👉 解锁 or 锁定 NextButton
func _check_all_selected():
	
	# 必须全部非空
	if CharactersChosen.group1_choice != "" and CharactersChosen.group2_choice != "" and CharactersChosen.group3_choice != "":
		next_button.disabled = false
	else:
		next_button.disabled = true
		
func _on_next_day_pressed() -> void:
	# 真人本人： 这里的print是用来展示效果的，以免咱不知道变量名是啥
	# 在其他场景要读取的话，可以通过GameData.group1_choice找到职业对应的string
	print(CharactersChosen.group1_choice)
	print(CharactersChosen.group2_choice)
	print(CharactersChosen.group3_choice)
	button_sound.play()
	const DEFAULT_SCENE_PATH := "res://scenes/scene/wild.tscn"
	Scene_Manager.change_scene(DEFAULT_SCENE_PATH)
