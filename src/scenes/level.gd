extends Node3D
enum FRUITS {banana, watermelon, apple}
@export var fruit_scene = preload("res://src/scenes/fruit.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	# Posición de la cámara
	var base_pos = $"../Camera3D".position
	
	# Vector que apunta hacia adelante (de la cámara) y rotación alrededor del eje Y
	var forward_vector = Vector3.FORWARD
	var random_angle = rng.randf_range(-PI/4, PI/4)
	$Timer.start(rng.randf_range(0.25, 3))
	
	# Rota el vector hacia adelante para generar un punto en una circunferencia de 1.5m
	var spawn_rotation = forward_vector.rotated(Vector3.UP, random_angle) * rng.randf_range(1.3, 1.5)
	
	# El punto de aparición estará a 1.5 metros frente a la cámara, en un ángulo aleatorio
	var spawn_point = Vector3(base_pos.x, 0, base_pos.z) + spawn_rotation
	
	# Instancia y coloca el objeto en el punto calculado
	var instance : RigidBody3D = fruit_scene.instantiate()
	instance.position = spawn_point
	#instance.apply_torque_impulse(Vector3(random_angle/10, random_angle/10, random_angle/10))
	instance.upwards_force_multiplier = rng.randf_range(2.75, 3.15)
	instance.SPIN_FORCE = Vector3(Vector3(random_angle, 2*random_angle, 3*random_angle))
	instance.rotate_z(random_angle)
	#instance.rotate_x(random_angle)
	add_child(instance)
	#var pos = Vector2(base_pos.x, base_pos.z)
	#var spawn_pos = Vector2(spawn_point.x, spawn_point.z)
	#print(spawn_pos.distance_to(pos))
