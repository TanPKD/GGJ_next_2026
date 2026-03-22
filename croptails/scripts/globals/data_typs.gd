class_name DataTypes
extends RefCounted

enum Tools {
	None,
	AxeWood,
	TillGround,
	WaterCrops,
	PlantCorn,
	PlantTomato
}

enum scene {
	main_menu,
	test_scene_default,
	test_scene_house_tilemap,
	test_scene_player,
	test_scene_tilemap
}

const SCENE_PATH_DICT: Dictionary = {
	scene.main_menu: "res://scenes/scene/main_menu.tscn",
	scene.test_scene_default: "res://scenes/test/test_scene_default.tscn",
	scene.test_scene_house_tilemap: "res://scenes/test/test_scene_house_tilemap.tscn",
	scene.test_scene_player: "res://scenes/test/test_scene_player.tscn",
	scene.test_scene_tilemap: "res://scenes/test/test_scene_tilemap.tscn"
}
<<<<<<< Updated upstream

=======
# 这些是以后要用的关卡循环代码，还没法验证能不能用

# 🔥 循环流程（不包含 main_menu）
>>>>>>> Stashed changes
const SCENE_FLOW: Array[scene] = [
	scene.test_scene_default,
	scene.test_scene_house_tilemap,
	scene.test_scene_player,
	scene.test_scene_tilemap
]
<<<<<<< Updated upstream
'''
static func get_next_scene(current: scene) -> scene:
	var index := SCENE_FLOW.find(current)
	if index == -1:
		return SCENE_FLOW[0]
	
	index += 1
	if index >= SCENE_FLOW.size():
		index = 0
	
	return SCENE_FLOW[index]
'''
=======

# 🔁 获取下一个场景（循环）
static func get_next_scene(current: scene) -> scene:
	var index = SCENE_FLOW.find(current)
	
	if index == -1:
		return SCENE_FLOW[0]  # 异常保护
	
	index += 1
	
	if index >= SCENE_FLOW.size():
		index = 0  # 循环回去
	
	return SCENE_FLOW[index]
>>>>>>> Stashed changes
