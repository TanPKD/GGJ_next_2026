extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var last_scene: DataTypes.scene = DataTypes.scene.test_scene_default
var is_changing: bool = false

func change_scene(target_scene: DataTypes.scene) -> void:
	if is_changing:
		return
	is_changing = true

	last_scene = target_scene

	animation_player.play("trans_out")
	await animation_player.animation_finished

	var scene_path: String = DataTypes.SCENE_PATH_DICT[target_scene]
	var packed_scene: PackedScene = load(scene_path)
	get_tree().change_scene_to_packed(packed_scene)

	await get_tree().process_frame

	animation_player.play("trans_in")
	is_changing = false
'''
func next_scene() -> void:
	var next_scene: DataTypes.scene = DataTypes.get_next_scene(last_scene)
	change_scene(next_scene)

func reload_scene() -> void:
	change_scene(last_scene)
'''
