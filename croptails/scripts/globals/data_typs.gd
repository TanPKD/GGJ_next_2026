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
# 这里有大量的历史遗落性问题，注释的代码基本上就是给我回忆用的废稿
'''
enum scene {
	main_menu,
	character_menu,
	test_scene_default,
	test_scene_house_tilemap,
	test_scene_player,
	test_scene_tilemap
}

const SCENE_PATH_DICT: Dictionary = {
	scene.main_menu: "res://scenes/scene/main_menu.tscn",
	scene.character_menu: "res://scenes/scene/character_menu.tscn",
	scene.test_scene_default: "res://scenes/test/test_scene_default.tscn",
	scene.test_scene_house_tilemap: "res://scenes/test/test_scene_house_tilemap.tscn",
	scene.test_scene_player: "res://scenes/test/test_scene_player.tscn",
	scene.test_scene_tilemap: "res://scenes/test/test_scene_tilemap.tscn"
}


const SCENE_FLOW: Array[scene] = [
	scene.test_scene_default,
	scene.test_scene_house_tilemap,
	scene.test_scene_player,
	scene.test_scene_tilemap
]

static func get_next_scene(current: scene) -> scene:
	var index := SCENE_FLOW.find(current)
	if index == -1:
		return SCENE_FLOW[0]
	
	index += 1
	if index >= SCENE_FLOW.size():
		index = 0
	
	return SCENE_FLOW[index]
'''
