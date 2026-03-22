#class_name SceneManager extends CanvasLayer
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

<<<<<<< Updated upstream
var last_scene: DataTypes.scene = DataTypes.scene.test_scene_default
var is_changing: bool = false
=======
var last_scene: DataTypes.scene
var is_changing: bool = false  # 防止重复点击
>>>>>>> Stashed changes

func change_scene(target_scene: DataTypes.scene) -> void:
	if is_changing:
		return
	is_changing = true
<<<<<<< Updated upstream

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
=======
	last_scene = target_scene
	# 1. 播放屏幕遮盖动画（比如屏幕变黑）
	animation_player.play("trans_out")
	await animation_player.animation_finished
	
	# 2. 此时屏幕完全被遮挡，安全地在后台切换场景
	var scene_path = DataTypes.SCENE_PATH_DICT[target_scene]
	var packed_scene = load(scene_path)
	get_tree().change_scene_to_packed(packed_scene)
	# 等一帧，确保新场景加载完成
	await get_tree().process_frame
	
	# 3. 场景加载完毕，播放屏幕揭开动画（比如黑屏消散）
	animation_player.play("trans_in")
	is_changing = false
	
# 这些是以后要用的关卡循环代码，还没法验证能不能用

# 🔁 下一关（循环）
>>>>>>> Stashed changes
func next_scene() -> void:
	var next_scene: DataTypes.scene = DataTypes.get_next_scene(last_scene)
	change_scene(next_scene)

<<<<<<< Updated upstream
func reload_scene() -> void:
	change_scene(last_scene)
'''
=======
# 🔙 返回上一关（可选）
func reload_scene() -> void:
	change_scene(last_scene)
>>>>>>> Stashed changes
