'''
extends Node
class_name GameInputEvents

static func movement_input() -> Vector2:
	# 这里必须用 get_vector，才能同时获取上下左右的组合输入
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


static func is_movement_input() -> bool:
	return movement_input() != Vector2.ZERO
	'''
