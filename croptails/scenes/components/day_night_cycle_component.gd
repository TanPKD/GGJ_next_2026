'''
class_name DayNightCycleComponent
extends CanvasModulate

@export var next_scene: PackedScene

@export var initial_day: int = 1:
	set(id):
		initial_day = id
		DayAndNightCycleManager.initial_day = id
		DayAndNightCycleManager.set_initial_time()

@export var initial_hour: int = 12:
	set(ih):
		initial_hour = ih
		DayAndNightCycleManager.initial_hour = ih
		DayAndNightCycleManager.set_initial_time()

@export var initial_minute: int = 30:
	set(im):
		initial_minute = im
		DayAndNightCycleManager.initial_minute = im
		DayAndNightCycleManager.set_initial_time()

@export var day_night_gradient_texture: GradientTexture1D

# ✅【新增函数】当进入新的一天时触发
func on_new_day(_day: int) -> void:
	# 防止没设置场景时报错
	if next_scene == null:
		return
	# ✅ 防止无限跳场景（关键！）
	DayAndNightCycleManager.set_initial_time()
	# ✅【这里就是场景切换位置】
	Scene_Manager.change_scene(next_scene.resource_path)
	
func _ready() -> void:
	DayAndNightCycleManager.initial_day = initial_day
	DayAndNightCycleManager.initial_hour = initial_hour
	DayAndNightCycleManager.initial_minute = initial_minute
	DayAndNightCycleManager.set_initial_time()
	
	DayAndNightCycleManager.game_time.connect(on_game_time)
	
	DayAndNightCycleManager.time_tick_day.connect(on_new_day)

func on_game_time(time: float) -> void:
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_gradient_texture.gradient.sample(sample_value)
	
# 修改管理器里的速度
func set_game_speed(multiplier: float):
	DayAndNightCycleManager.game_speed = multiplier

func _process(_delta: float) -> void:
	var a = (initial_day+1)
	if DayAndNightCycleManager.initial_day = a:
	

func _input(event):

	if event.is_action_pressed("speed_up"):
		DayAndNightCycleManager.game_speed = 5000.0 
	elif event.is_action_released("speed_up"):
		DayAndNightCycleManager.game_speed = 5.0
'''

extends CanvasModulate

@export var next_scene: PackedScene

@export var initial_day: int = 1:
	set(id):
		initial_day = id
		DayAndNightCycleManager.initial_day = id
		DayAndNightCycleManager.set_initial_time()

@export var initial_hour: int = 12:
	set(ih):
		initial_hour = ih
		DayAndNightCycleManager.initial_hour = ih
		DayAndNightCycleManager.set_initial_time()

@export var initial_minute: int = 30:
	set(im):
		initial_minute = im
		DayAndNightCycleManager.initial_minute = im
		DayAndNightCycleManager.set_initial_time()

@export var day_night_gradient_texture: GradientTexture1D

func _ready() -> void:
	DayAndNightCycleManager.initial_day = initial_day
	DayAndNightCycleManager.initial_hour = initial_hour
	DayAndNightCycleManager.initial_minute = initial_minute
	DayAndNightCycleManager.set_initial_time()

	DayAndNightCycleManager.game_time.connect(on_game_time)
	DayAndNightCycleManager.time_tick_day.connect(on_new_day)

# 当进入新的一天时触发
func on_new_day(_day: int) -> void:
	if next_scene == null:
		return

	# 防止切场景后立刻又被当成新的一天
	DayAndNightCycleManager.set_initial_time()

	# 这里调用你的场景切换函数
	Scene_Manager.change_scene(next_scene.resource_path)

func on_game_time(time: float) -> void:
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_gradient_texture.gradient.sample(sample_value)

# 修改管理器里的速度
func set_game_speed(multiplier: float):
	DayAndNightCycleManager.game_speed = multiplier

func _input(event):
	if event.is_action_pressed("speed_up"):
		DayAndNightCycleManager.game_speed = 5000.0
	elif event.is_action_released("speed_up"):
		DayAndNightCycleManager.game_speed = 5.0
