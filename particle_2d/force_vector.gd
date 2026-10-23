extends Node2D

class_name ForceVector

@export var exaggeration : float = 3
var force : Vector2 = Vector2.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Line2D.set_point_position(1, exaggeration * force)
