extends Node

@export_enum("Bomb", "Apple") var spawnable : String
@export var spawnable_fruit = preload("res://src/scenes/fruit.tscn")

var rng = RandomNumberGenerator.new()
var score : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var base_pos = $"../XROrigin3D".position
	var random_angle = rng.randf_range(-PI/4, PI/4)
	$Timer.start(rng.randf_range(0.25, 3.0))
	
	var spawn_rotation = Vector3.FORWARD.rotated(Vector3.UP, random_angle) * rng.randf_range(1.3, 1.5)
	
	var spawn_point = Vector3(base_pos.x, 0, base_pos.z) + spawn_rotation
	
	var instance : RigidBody3D = spawnable_fruit.instantiate()
	instance.position = spawn_point
	instance.upward_force_multiplier = rng.randf_range(2.75,3.15)
	instance.spin_force = Vector3(random_angle, 2* random_angle, 3* random_angle)
	instance.rotate_z(random_angle)
	add_child(instance)


func _on_sword_fruit_contact() -> void:
	score+=1
	$Score.text = str(score)
