extends CharacterBody3D

signal fruit_contact

var last_touched

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	#...
	move_and_slide()

	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)
		var object_in_contact = collision.get_collider()
		# If the collision is with ground
		if object_in_contact == null || object_in_contact == last_touched:
			continue

		if object_in_contact.is_in_group("fruit"):
			last_touched = object_in_contact
			fruit_contact.emit()
				# Prevent further duplicate calls.
			break
