extends RigidBody3D
class_name Fruit
enum Fruits {bomb, orange, apple, watermelon}

const LAUNCH_FORCE = Vector3.ONE  # Fuerza inicial hacia arriba (ajusta según lo necesites)
@export var spin_force = Vector3.ONE   # Fuerza de giro si quieres que rote en el aire
@export var upward_force_multiplier = 3
@export var fruit_type : Fruits
@export var shape : Shape3D
@export var mesh : Mesh

func _ready():
	$Mesh.mesh = mesh
	$CollisionShape3D.shape = shape
	# Aplica un impulso hacia arriba
	apply_impulse(Vector3.UP * upward_force_multiplier, LAUNCH_FORCE)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Aplica un impulso para rotar en el aire (opcional)
	apply_torque_impulse(spin_force * 0.00001)


func _on_timer_timeout():
	self.queue_free()
