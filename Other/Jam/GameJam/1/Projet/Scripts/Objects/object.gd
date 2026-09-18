extends CharacterBody2D

@export var SLOWNESS: float = 10.0
@export var DROP_SPEED: float = 1500.0
@export var objectType = "banane"

var player_chase = false
var player = null
var object = null

var scene_boomerang = "res://Scenes/Objects/boomerang.tscn"
var scene_banane = "res://Scenes/Objects/banane.tscn"
var scene_aubergine = "res://Scenes/Objects/aubergine.tscn"

# Mask : Object X exists on specified layers
# Layer: Object X will interact with other objects on specified layers

func _physics_process(delta):
	
	# Inactive in case of idling
	if player_chase:
		position += (player.position - position)/SLOWNESS
		if Input.is_action_just_pressed("drop_and_keep") and player_chase:
			drop_and_keep()
		if Input.is_action_just_pressed("drop") and player_chase:
			drop()
	velocity.x = move_toward(velocity.x, 0, 300)
	velocity.y = move_toward(velocity.y, 0, 300)
	move_and_slide()

# Détection du joueur
func _on_area_2d_body_entered(body):
	
	player = body
	if not player.is_holding_object:
		player.is_holding_object = true
		player_chase = true

# Détection de sortie du joueur
func _on_area_2d_body_exited(body):
	#player = null
	#player_chase = false
	pass

func drop_and_keep():
	velocity.x = Vector2.from_angle(player.rotation+deg_to_rad(-90)).x*DROP_SPEED
	velocity.y = Vector2.from_angle(player.rotation+deg_to_rad(90)).y*DROP_SPEED
	player_chase = false
	$Drop_cooldown.start()

func drop():
	velocity.x = Vector2.from_angle(player.rotation+deg_to_rad(-90)).x*DROP_SPEED
	velocity.y = Vector2.from_angle(player.rotation+deg_to_rad(90)).y*DROP_SPEED
	player_chase = false
	player.is_holding_object = false
	player = null

func _on_drop_cooldown_timeout():
	if player != null:
		player_chase = true

# Détection d'objet
func _on_object_detection_body_entered(body):
	object = body
	if (not object == null) and (not object.objectType == "Player"):
		interact(object)
		
# Seul les interactions inter-items sont pointée ici.
func interact(object):
	if objectType == "banane" and object.objectType == "aubergine":
		fusion(object, scene_boomerang, object.position)
	elif objectType == "banane" and object.objectType == "économe":
		pass # Epluchure
	elif objectType == "banane" and object.objectType == "crème glacée":
		pass # Banana Split
	elif objectType == "ballon" and object.objectType == "???":
		pass
	else:
		object = null # Ne pas prendre en compte l'intéraction
	
func fusion(object, newObject, spawnPosition):
	#Suppression de l'autre objet
	object.queue_free()
	
	if(player != null):
		player.is_holding_object = false
		player_chase = false
		player = null
	
	# Création de la nouvelle scène
	var scene = load(newObject)
	var instance = scene.instantiate()
	instance.position = spawnPosition
	add_sibling(instance)
	
	# ADIOS
	queue_free()
