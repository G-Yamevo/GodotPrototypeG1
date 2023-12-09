extends CharacterBody2D


@export var speed = 150
var screen_size
var jump_vel = 100
var grav = 1
var is_attacking = false
var attack_dir = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = $IdleTimer
	if velocity.length() == 0 and is_attacking == false:
		timer.start()
	
	screen_size = get_viewport_rect().size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movementManagement(delta)


func _movementManagement(delta):
	print_debug(delta)
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right") and is_attacking == false:
		velocity.x += 1
		velocity = velocity.normalized() * speed
		$AnimatedSprite2d.flip_h = false
		$AnimatedSprite2d.play("Walk")
		attack_dir = 1
	if Input.is_action_pressed("move_left") and is_attacking == false:
		velocity.x -=1
		velocity = velocity.normalized() * speed
		$AnimatedSprite2d.flip_h = true
		$AnimatedSprite2d.play("Walk")
		attack_dir =-1

	if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			velocity.y += velocity.y + jump_vel * delta
			position.y += position.y + velocity.y + 1/2 * grav * delta * delta

	if Input.is_action_pressed("attack1"):
		is_attacking = true
		$AttackTimer.start()
		if attack_dir < 0:
			$AnimatedSprite2d.flip_h = true
			$AnimatedSprite2d.play("Attack1")
		else:
			$AnimatedSprite2d.flip_h = false
			$AnimatedSprite2d.play("Attack1")
			$AnimatedSprite2d/Attack1Area/CollisionShape2D.disabled = false
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)	

func _on_idle_timer_timeout():
	$AnimatedSprite2d.play("Idle")


func _on_attack_timer_timeout():
	return true


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2d.animation == "Attack1":
		is_attacking = false
		$AnimatedSprite2d/Attack1Area/CollisionShape2D.disabled = true
	
	$AnimatedSprite2d.stop()


