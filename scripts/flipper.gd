class_name Flipper
extends AnimatableBody2D

@export var pressed_angle: float
@export var rest_angle: float
@export var flipper_speed := 360.0 # degrees per second
@export var trigger: String

var target_angle := rest_angle

func _physics_process(delta):
	if Input.is_action_pressed(trigger):
		target_angle = pressed_angle
	else:
		target_angle = rest_angle

	var current_angle = rotation_degrees
	var angle_diff = target_angle - current_angle
	var max_step = flipper_speed * delta
	angle_diff = clamp(angle_diff, -max_step, max_step)
	rotation_degrees += angle_diff


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		SignalBus.emit_signal("hitstun")
