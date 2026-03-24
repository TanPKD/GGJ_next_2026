extends Camera2D 

func _input(event : InputEvent) -> void:
	# 按shift缩放
	if event.is_action_pressed("shift"):
		set_zoom(Vector2(1.5, 1.5))
		return
	if event.is_action_released("shift"):
		set_zoom(Vector2(2, 2))
		return
	if event.is_action_pressed("shake"):
		$".".shake()

func shake() -> void:
	# 按u抖动，准确点说是.shake()
	var shake_tween = create_tween()
	var random_num = randi_range(2, 1)
	shake_tween.tween_property(self, "offset", offset + Vector2(-random_num, -random_num), 0.05)
	shake_tween.tween_property(self, "offset", offset + Vector2(random_num, random_num), 0.05)
	shake_tween.tween_property(self, "offset", offset + Vector2(random_num, -random_num), 0.05)
	shake_tween.tween_property(self, "offset", offset + Vector2(-random_num, random_num), 0.05)
	shake_tween.tween_property(self, "offset", Vector2(0, 0), 0.05)
	
