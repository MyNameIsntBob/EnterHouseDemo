extends Node2D

var entered = false

var outside = "res://Scene/Outside.tscn"

func _on_Exit_body_entered(body):
	if entered:
		get_tree().change_scene(outside)


func _on_Exit_body_exited(body):
	entered = true
