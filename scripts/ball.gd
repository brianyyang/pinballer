class_name Ball
extends RigidBody2D

@export var radius: int
@export var color: Color
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var original_position := position
var reset_state := false
var freeze_time := 0

func _ready() -> void:
	SignalBus.connect("hitstun", Callable(self, "_on_hitstun"))
	collision_shape.shape.radius = radius

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("restart"):
		reset_state = true
	if freeze_time > 0:
		freeze_time -= delta
		if freeze_time <= 0:
			call_deferred("set_freeze", false)

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, original_position)
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		reset_state = false

func _on_hitstun() -> void:
	pass
	# call_deferred("set_freeze", true)
	# freeze_time = 1

func set_freeze(value: bool) -> void:
	freeze = value
