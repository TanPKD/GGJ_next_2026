extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_changing: bool = false

func change_scene(target_scene: String) -> void:
	if is_changing:
		return
	is_changing = true

	# 黑屏
	animation_player.play("trans_out")
	await animation_player.animation_finished

	# 切场景
	var packed_scene: PackedScene = load(target_scene)
	if packed_scene == null:
		push_error("加载失败: " + target_scene)
		is_changing = false
		return
		
	get_tree().change_scene_to_packed(packed_scene)

	await get_tree().process_frame

	# 淡入
	animation_player.play("trans_in")

	is_changing = false
'''
func next_scene() -> void:
	var next_scene: DataTypes.scene = DataTypes.get_next_scene(last_scene)
	change_scene(next_scene)

func reload_scene() -> void:
	change_scene(last_scene)
'''
