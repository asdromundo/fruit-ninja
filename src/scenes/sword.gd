extends CharacterBody3D

signal fruit_contact
signal bomb_contact
signal button_contact

var last_touched : Fruit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func _physics_process(_delta):
	##...
	#move_and_slide()
#
	## Iterate through all collisions that occurred this frame
	#for index in range(get_slide_collision_count()):
		## We get one of the collisions with the player
		#var collision = get_slide_collision(index)
		#var object_in_contact = collision.get_collider()
		## If the collision is with ground
		#if object_in_contact == null || object_in_contact == last_touched:
			#continue
#
		#if object_in_contact.is_in_group("fruit"):
			#last_touched = object_in_contact
			#fruit_contact.emit()
				## Prevent further duplicate calls.
			#break

func _physics_process(_delta):
	# Detecta colisiones pero sin afectar la posición de la espada
	var collision = move_and_collide(Vector3.ZERO, true)

	# Si hubo una colisión, la manejamos
	if collision:
		var object_in_contact = collision.get_collider()

		# Ignora si el objeto es nulo o ya ha sido tocado
		if object_in_contact == null or object_in_contact == last_touched:
			return

		# Si colisionó con un objeto del grupo "fruit"
		if object_in_contact.is_in_group("bomb"):
			last_touched = object_in_contact
			bomb_contact.emit()
		elif object_in_contact.is_in_group("button"):
			button_contact.emit()
		elif object_in_contact.is_in_group("fruit"):
			last_touched = object_in_contact
			fruit_contact.emit()
			# Opcionalmente, aquí puedes eliminar la fruta o manejar el corte.
