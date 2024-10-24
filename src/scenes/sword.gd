extends CharacterBody3D

signal fruit_contact
signal bomb_contact(bomb : Bomb)
signal button_contact

var last_touched
var mesh = MeshInstance3D
var mesh_slicer

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh = MeshInstance3D.new()
	mesh.mesh = QuadMesh.new()
	mesh_slicer = $MeshSlicer

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
		last_touched = object_in_contact
		# Si colisionó con un objeto del grupo "fruit"
		if object_in_contact.is_in_group("bomb"):
			bomb_contact.emit(object_in_contact as Bomb)
			return
		elif object_in_contact.is_in_group("button"):
			button_contact.emit()
		elif object_in_contact.is_in_group("fruit"):
			fruit_contact.emit()
			# Opcionalmente, aquí puedes eliminar la fruta o manejar el corte.
			
		#add_child(mesh)
		#mesh.position = collision.get_position()
		#var tmp_transform = mesh.global_transform
		#var cuttable = object_in_contact
		#tmp_transform.origin = cuttable.to_local(tmp_transform.origin)
		#tmp_transform.basis.x = cuttable.to_local(tmp_transform.basis.x+mesh.global_position)
		#tmp_transform.basis.y = cuttable.to_local(tmp_transform.basis.y+mesh.global_position)
		#tmp_transform.basis.z = cuttable.to_local(tmp_transform.basis.z+mesh.global_position)
#
		#var meshes = mesh_slicer.slice_mesh(tmp_transform, cuttable.mesh)
		#cuttable.mesh = meshes[0]
		#print(object_in_contact.get_children())
