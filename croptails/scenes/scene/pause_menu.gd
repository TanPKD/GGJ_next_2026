extends CanvasLayer

# 这里其实和@onready var pause_panel: Panel = $Control/Panel功能一样
# 只不过教程是用的这个，说是允许每次导用独立赋值，灵活性高点
# 但在这里因为我是直接应用到player.tscn里所以没法独立赋值:D
# 赋值可以在PauseUI的检查器里更改
@export var pause_panel: Panel
@export var BGM_Player: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
'''
func _process(_delta: float) -> void:
	# linear是将分贝值转换成线性值，不是线性渐变的意思
	var volume_linear = db_to_linear(BGM_player.volume_db)
	# 音量在暂停时为0，不然就是1（这也有三元运算符看哦>:/）
	var target_volume = 0.0 if  get_tree().paused else 1.0
	# lerp函数进行渐变，第三个参数决定如何前两个参数定义的线段两端渐变
	# lerp为0时返回值即为第一个参数，为1时为第二个参数
	# 第三个参数越大渐变越快，因为在_process()所以要乘以delta
	# 德芙，尽享丝滑
	volume_linear = lerp(volume_linear, target_volume, delta * 15) 
	BGM_Player.volume_db = linear_to_db(volume_linear)
'''
func _input(event : InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if not get_tree().paused:
			pause()
		else:
			unpause()

func pause():
	get_tree().paused = true
	pause_panel.visible = true
func unpause():
	get_tree().paused = false
	pause_panel.visible = false
	
func quit_game():
	get_tree().quit()
