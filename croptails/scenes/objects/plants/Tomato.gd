extends Node2D

var tomato_harvest_scene = preload("res://scenes/objects/tomatoHarvest.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var GrowthCycleComponent: GrowthCycleComponent = $GrowthCycleComponent
@onready var HurtComponent: HurtComponent = $HurtComponent

var growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Seed
var start_tomato_frame_offset:int=6


func _ready() -> void:

	HurtComponent.hurt.connect(onHurt)
	GrowthCycleComponent.crop_harvesting.connect(onCropHarvesting)

func _process(delta:float) -> void:
	growth_state = GrowthCycleComponent.get_current_growth_state()
	sprite_2d.frame = growth_state + start_tomato_frame_offset
	

func onHurt(hit_damage: int) -> void:
	if !GrowthCycleComponent.is_watered:
		await get_tree().create_timer(5.0).timeout
		GrowthCycleComponent.is_watered = true

	
func onCropHarvesting() -> void:
	var tomato_harvest_instance = tomato_harvest_scene.instantiate() as Node2D
	get_parent().add_child(tomato_harvest_instance)
	queue_free()
	tomato_harvest_instance.global_position = global_position
