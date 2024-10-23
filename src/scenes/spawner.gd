extends Node

@export var spawnable_fruit = preload("res://src/scenes/fruit.tscn")
var bombs = preload("res://bomb.tscn")

var rng = RandomNumberGenerator.new()
var time : float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta

func fruit_factory() -> Fruit:
	var shape : Shape3D
	var mesh : Mesh
	var material : BaseMaterial3D = StandardMaterial3D.new()
	var instance : Fruit
	var fruit_type : int
	# From all the posible options
	var total_fruits = Fruit.Fruits.size()
	# We want the bomb to be dependant on time
	var is_bomb : bool = 0.05 + (log(time)/log(10))*0.1 > rng.randf()

	if is_bomb:
		instance = bombs.instantiate()
		fruit_type = Fruit.Fruits.bomb
		shape = SphereShape3D.new()
		shape.radius = 0.15
		mesh = SphereMesh.new()
		mesh.radius = 0.15
		mesh.height = mesh.radius * 2
		material.albedo_color = Color(0.1,0.1,0.1,1)
	else:
		instance= spawnable_fruit.instantiate()
		fruit_type = rng.randi_range(1, total_fruits-1)
		match fruit_type:
			Fruit.Fruits.apple:
				shape = SphereShape3D.new()
				shape.radius = 0.125
				mesh = SphereMesh.new()
				mesh.radius = 0.125
				mesh.height = mesh.radius * 2
				material.albedo_color = Color("ff0000")
			Fruit.Fruits.watermelon:
				shape = CapsuleShape3D.new()
				shape.radius = 0.15
				shape.height = shape.radius * 3
				mesh = SphereMesh.new()
				mesh.radius = 0.15
				mesh.height = mesh.radius * 3
				material.albedo_color = Color("009000")
			Fruit.Fruits.orange:
				shape = SphereShape3D.new()
				shape.radius = 0.125
				mesh = SphereMesh.new()
				mesh.radius = 0.125
				mesh.height = mesh.radius * 2
				material.albedo_color = Color("ff4500")

	instance.fruit_type = fruit_type
	mesh.material = material
	instance.mesh = mesh
	instance.shape = shape
	return instance

func _on_timer_timeout() -> void:
	var base_pos = $"../XROrigin3D".position
	var random_angle = rng.randf_range(-PI/4, PI/4)
	$Timer.start(rng.randf_range(0.25, 3.0))
	
	var spawn_rotation = Vector3.FORWARD.rotated(Vector3.UP, random_angle) * rng.randf_range(1.3, 1.5)
	
	var spawn_point = Vector3(base_pos.x, 0, base_pos.z) + spawn_rotation
	
	var instance : Fruit = fruit_factory()
	instance.position = spawn_point
	instance.upward_force_multiplier = rng.randf_range(2.75,3.15)
	instance.spin_force = Vector3(random_angle, 2* random_angle, 3* random_angle)
	instance.rotate_y(2*random_angle)
	add_child(instance)
