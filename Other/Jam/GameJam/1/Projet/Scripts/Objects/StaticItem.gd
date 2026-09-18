extends Node2D

@export var objectType = "micro-onde"
var object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	object = body
	if not object.objectType == "player":
		interact(object)

# interaction avec des éléments statique
func interact(object):
	if objectType == "micro-onde" and object.objectType == "fourchette":
		explode()
	elif objectType == "évier" and object.objectType == "batte":
		pass # gen flaque
	elif objectType == "lave-vaisselle" and object.objectType == "assiette":
		pass # gen gonfleur
	elif objectType == "grille-pain" and object.objectType == "flaque":
		pass # gen ???
	elif objectType == "fenêtre" and object.objectType == "boomerang":
		pass # gen ??? <truc qui revient random>

func _on_area_2d_body_exited(body):
	pass # Replace with function body.

# Fait exploser l'objet: Change sprite + Suppr + Scoring
func explode():
	pass
