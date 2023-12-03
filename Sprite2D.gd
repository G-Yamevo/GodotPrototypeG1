extends Sprite2D

var speed = 400
var angular_speed = PI


func _process(delta):
	
	var direction = 0 
	if Input.is_key_pressed(KEY_A):
		direction = -1
	if Input.is_key_pressed(KEY_D):
		direction = 1
	
	rotation += angular_speed * direction * delta
	
	var velocity = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
		
	


func _on_button_pressed():
	set_process(not is_processing())
	
func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	visible = not visible

	
