extends Area3D

@export var camera_path: NodePath

func _on_body_entered(body):
	if body.name == "Player": # asegúrate de que tu jugador se llame igual
		var cam = get_node(camera_path)
		cam.target_offset = cam.zoomed_offset

func _on_body_exited(body):
	if body.name == "Player":
		var cam = get_node(camera_path)
		cam.target_offset = cam.normal_offset
