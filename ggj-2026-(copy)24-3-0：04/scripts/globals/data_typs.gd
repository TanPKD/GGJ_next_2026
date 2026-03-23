class_name DataTypes

enum GrowthStates {
	Seed,
	Germination,
	Vegetative,
	Reproduction,
	Maturity,
	Harvesting
}

enum Tools {
	None,
	AxeWood,
	TillGround,
	WaterCrops,
	PlantCorn,
	PlantTomato
}

enum scene {
	test_scene_default,
	test_scene_house_tilemap,
	test_scene_player,
	test_scene_tilemap
}

const SCENE_PATH_DICT: Dictionary = {
	DataTypes.scene.test_scene_default: "res://scenes/test/test_scene_default.tscn",
	DataTypes.scene.test_scene_house_tilemap: "res://scenes/test/test_scene_house_tilemap.tscn",
	DataTypes.scene.test_scene_player: "res://scenes/test/test_scene_player.tscn",
	DataTypes.scene.test_scene_tilemap: "res://scenes/test/test_scene_tilemap.tscn"
}
