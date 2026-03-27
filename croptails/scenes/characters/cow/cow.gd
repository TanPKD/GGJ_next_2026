extends NonPlayableCharacter
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
var meat_scene = preload("res://scenes/objects/meat.tscn")

func _ready() -> void:
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damage_reached)


func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)

func on_max_damage_reached() -> void:
	call_deferred("add_meat_scene")
	call_deferred("add_meat_scene")
	print("max damaged reached")
	queue_free()

func add_meat_scene() -> void:
	var meat_instance = meat_scene.instantiate() as Node2D 
	meat_instance.global_position = global_position
	get_parent().add_child(meat_instance)
