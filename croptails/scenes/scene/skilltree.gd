extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_5_pressed() -> void:
	const DEFAULT_SCENE_PATH := "res://scenes/scene/character_menu.tscn"
	Scene_Manager.change_scene(DEFAULT_SCENE_PATH)
