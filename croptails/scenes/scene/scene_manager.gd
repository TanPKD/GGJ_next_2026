extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

#var last_scene: Constants.Scene
#
#func change_scene(env: Node, target_scene: Constants.Scene) -> void:
	#last_scene = target_scene
	#animation_player.play("trans_out")
	#await animation_player.animation_finished
	#var scene_path = Constants.SCENE_PATH_DICT[target_scene]
	#env.get_tree().change_scene_to_packed(load(scene_path))
	#animation_player.play("trans_in")
