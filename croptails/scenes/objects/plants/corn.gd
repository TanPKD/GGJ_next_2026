extends Node2D

var corn_harvest_scene = preload("res://scenes/objects/plants/cornHarvest.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var WateringParticles: GPUParticles2D = $WateringParticles
@onready var FlowerParticles: GPUParticles2D = $FlowerParticles
@onready var GrowthCycleComponent: GrowthCycleComponent = $GrowthCycleComponent
@onready var HurtComponent: HurtComponent = $HurtComponent

var growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Seed

func _ready() -> void:
	WateringParticles.emitting = false
	FlowerParticles.emitting = false

	HurtComponent.hurt.connect(onHurt)
	GrowthCycleComponent.crop_maturity.connect(onCropMaturity)
	GrowthCycleComponent.crop_harvesting.connect(onCropHarvesting)

func _process(delta:float) -> void:
	growth_state = GrowthCycleComponent.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Maturity:
		FlowerParticles.emitting = true

func onHurt(hit_damage: int) -> void:
	if !GrowthCycleComponent.is_watered:
		WateringParticles.emitting = true
		await get_tree().create_timer(5.0).timeout
		WateringParticles.emitting = false
		GrowthCycleComponent.is_watered = true

func onCropMaturity() -> void:
	FlowerParticles.emitting = true
	
func onCropHarvesting() -> void:
	var corn_harvest_instance = corn_harvest_scene.instantiate() as Node2D
	get_parent().add_child(corn_harvest_instance)
	queue_free()
	corn_harvest_instance.global_position = global_position
	
	
	
	
