extends Node2D

export (PackedScene) var inside_scene

func _on_DoorWay_body_entered(body):
	body.house = self


func _on_DoorWay_body_exited(body):
	if body.house == self:
		body.house = null

func enter():
	get_tree().change_scene(inside_scene.resource_path)
