extends Fruit
class_name Bomb

@onready var explotion = $Explotion

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
