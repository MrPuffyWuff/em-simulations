extends CharacterBody2D

class_name Particle2D

const COULOMB_CONST : float = 9.0 * 10**9

@export var stats : Particle2DRes
@export var freeze_position : bool = false
@export var freeze_velocity : bool = false
@export var freeze_acceleration : bool = false

var accel : Vector2 = Vector2.ZERO

func _ready() -> void:
	GameState.electrons.append(self)
	if stats.charge > 0:
		$Sprite2D.region_rect = Rect2(0,48,48,48)
	else:
		velocity = Vector2.RIGHT * 50

func _physics_process(delta: float) -> void:
	
	if not freeze_acceleration:
		accel = Vector2.ZERO
		for p : Particle2D in GameState.electrons:
			if p == self:
				continue
			accel += coulomb_force(self, p, 1000)
		print(accel)
		$ForceVector.force = accel * stats.mass
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not freeze_velocity:
		velocity += accel * delta
	if not freeze_position:
		move_and_slide()

static func coulomb_force(me : Particle2D, other : Particle2D, k : float) -> Vector2:
	'''
	a = (k * q_1 * q_2) / (m * r^2)
	'''
	var numerator  : float = k * me.stats.charge * other.stats.charge
	var denominator : float = me.stats.mass * (me.position - other.position).length_squared()
	return (me.position - other.position) * (numerator / denominator)
	
