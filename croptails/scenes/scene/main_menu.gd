extends Control

# @onready var scene_manager: CanvasLayer = $SceneManager
@export var button_sound: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$main_main_menu.visible = true
	$credit_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	button_sound.play()
	const DEFAULT_SCENE_PATH := "res://scenes/scene/character_menu.tscn"
	Scene_Manager.change_scene(DEFAULT_SCENE_PATH)
	# Scene_Manager.change_scene(DataTypes.scene.character_menu)
	# 对其他关卡用，因为主页不参与游戏天数的循环
	#func _on_next_pressed() -> void:
	#	SceneManager.next_scene()
	
func _on_setting_pressed() -> void:
	print("2")
	
	
func _on_credit_pressed() -> void:
	$Label.visible = false
	$main_main_menu.visible = false
	$credit_menu.visible = true
	button_sound.play()
	
func _on_credit_back_pressed() -> void:
	$Label.visible = true
	$main_main_menu.visible = true
	$credit_menu.visible = false
	button_sound.play()

func _on_exit_pressed() -> void:
	get_tree().quit()
