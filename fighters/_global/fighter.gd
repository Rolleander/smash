class_name Fighter extends CharacterBody2D

@export var sprite: Node2D
@export var animations: AnimationPlayer

@export var collision: CollisionShape2D
@export var hurtBox: Area2D
@export var tumbleCollision: CollisionShape2D
@export var tumbleSmoke: TumbleSmoke
@export var rcGroundL: RayCast2D
@export var rcGroundR: RayCast2D
@export var rcLedgeGrabF: LedgeScan
@export var rcLedgeGrabB: LedgeScan
@export var stateMachine: StateMachine
@export var shield: Shield

@export var atts: FighterAttributes

var state: String
var lagFrames = 0
var fastFall = false
var airJumps = 0
var controllerId = 0
var alive = true
var hideCamera = false
var dropFromY = 0
var facingRight = true
var percentage = 0
var stocks = 3
var invincible = false
var knockback = FighterKnockback.new(self)
var freeze = FreezFrames.new(self)
var moves = MoveHandler.new(self)
var grabbingLedge: Ledge = null
var regrabPause = 0

var flickScan = FlickScan.new(self, 3)

func _ready() -> void:
	moves.ready()

func _physics_process(delta: float) -> void:
	# make sure the ground raycasts always point downwards, even if character is rotated
	_angle_down(rcGroundL)
	_angle_down(rcGroundR)
	
func _angle_down(node: Node2D):
	node.global_transform = Transform2D(deg_to_rad(0), node.global_position)

func turn(left: bool):
	sprite.flip_h = left
	facingRight = !left
	rcLedgeGrabF.turn(left)
	rcLedgeGrabB.turn(left)

func intangible(on: bool):
	hurtBox.monitoring = !on

func kill():
	alive = false
	stateMachine.force_state("KO")

func direction():
	if facingRight:
		return 1
	return -1

func isLanding() -> bool:
	return inState(["AIR"]) and (rcGroundL.is_colliding() or rcGroundR.is_colliding()) and velocity.y >= 0
	
func isStartingToFall() -> bool:
	return inState(["STAND", "DASH", "RUN", "WALK", "TURN", "BRAKE", "SHIELD", "ROLL"]) and not rcGroundL.is_colliding() and not rcGroundR.is_colliding()

func isGrounded() -> bool:
	return inState(["RUN", "WALK", "DASH", "TURN", "BRAKE", "ATTACK", "SHIELD", "CROUCH", "ROLL"])

func shouldGrabLedge():
	if !inState(["AIR"]):
		return null
	if rcLedgeGrabF.is_colliding():
		var ledge = rcLedgeGrabF.get_collider() as Ledge
		if ledge.canBeGrabbedBy(self):
			return ledge
	if rcLedgeGrabB.is_colliding():
		var ledge = rcLedgeGrabB.get_collider() as Ledge
		if ledge.canBeGrabbedBy(self):
			return ledge
	return null

func enablePlatformCollision(enabled: bool):
	set_collision_mask_value(3, enabled)
	rcGroundL.set_collision_mask_value(3, enabled)
	rcGroundR.set_collision_mask_value(3, enabled)
	
func onPlatform() -> bool:
	const PLATFORM_LAYER = 2 # layer 3 = bit 2
	const WALL_LAYER = 1 # layer 2 = bit 1
	var left_layer = 0
	var right_layer = 0
	var left_hit = rcGroundL.get_collider()
	if left_hit:
		left_layer = left_hit.get_collision_layer()
	var right_hit = rcGroundR.get_collider()
	if right_hit:
		right_layer = right_hit.get_collision_layer()
	var touches_platform = (left_layer & (1 << PLATFORM_LAYER)) != 0 or (right_layer & (1 << PLATFORM_LAYER)) != 0
	var touches_wall = (left_layer & (1 << WALL_LAYER)) != 0 or (right_layer & (1 << WALL_LAYER)) != 0
	return touches_platform and not touches_wall

func inState(states: Array[String]):
	for s in states:
		if state == s:
			return true
	return false

func dampenHorizontalMovement(slowdown: float = atts.traction):
	if velocity.x > 0:
		velocity.x += -slowdown
		velocity.x = max(velocity.x, 0)
	elif velocity.x < 0:
		velocity.x += slowdown
		velocity.x = min(velocity.x, 0)

func veffect(effect: VEffect, offset: Vector2 = Vector2(0, 0)):
	effect.global_position = global_position + offset
	get_tree().get_first_node_in_group("veffects_node").add_child(effect)

func animation(new_anim: String, overwrite = false) -> void:
	if not animations.has_animation(new_anim):
		push_warning("Animation not found: " + new_anim)
		return
	var current_anim = animations.current_animation
	if current_anim == new_anim:
		return
	if !animations.has_animation(current_anim):
		animations.play(new_anim)
		return
	var anim = animations.get_animation(current_anim)
	if overwrite or not anim or anim.loop_mode != Animation.LOOP_NONE:
		if overwrite:
			animations.stop();
		animations.play(new_anim)
	else:
		if animations.current_animation_position >= animations.current_animation_length:
			animations.play(new_anim)

func applySlopeVerticalSpeed():
	var normal = null
	if facingRight:
		if rcGroundR.is_colliding():
			normal = rcGroundR.get_collision_normal()
		elif rcGroundL.is_colliding():
			normal = rcGroundL.get_collision_normal()
	else:
		if rcGroundL.is_colliding():
			normal = rcGroundL.get_collision_normal()
		elif rcGroundR.is_colliding():
			normal = rcGroundR.get_collision_normal()
	if normal == null:
		return
	var slope_direction = Vector2(normal.y, -normal.x)
	#check for downwards slope normal
	if (facingRight && slope_direction.y < 0) || (!facingRight && slope_direction.y > 0):
		velocity.y = max(15, abs(velocity.x) * abs(slope_direction.y) * 2)

signal on_landing()
signal on_ledge_catch()
signal on_spawn()
