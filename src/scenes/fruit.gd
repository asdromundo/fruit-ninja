extends RigidBody3D
const LAUNCH_FORCE = Vector3.ONE  # Fuerza inicial hacia arriba (ajusta según lo necesites)
@export var spin_force = Vector3.ONE   # Fuerza de giro si quieres que rote en el aire
@export var upward_force_multiplier = 3

func _ready():
	# Aplica un impulso hacia arriba
	apply_impulse(Vector3(-0.01, 1, 0.03) * upward_force_multiplier, LAUNCH_FORCE)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Aplica un impulso para rotar en el aire (opcional)
	apply_torque_impulse(spin_force * 0.00001)


func _on_timer_timeout():
	self.queue_free()
