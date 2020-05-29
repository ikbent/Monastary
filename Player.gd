extends KinematicBody



var velocity = Vector3()
const FLY_SPEED = 10
const FLY_ACCELL = 2
var mouse_sensitivity = 0.3
var camera_angle = 0

var p = 0;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	PlayerStats.connect("vomit", self, "_on_PlayerStats_vomit")

func _input(event):
	if event is InputEventMouseMotion and get_parent().enabled:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var change = -event.relative.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
			camera_angle += change;
			$Head/Camera.rotate_x(deg2rad(change))

func _physics_process(delta):
	if  get_parent().enabled:
		var direction = Vector3()
		var aim = $Head/Camera.get_global_transform().basis
		if Input.is_action_pressed("move_forward"):
			direction -= aim.z
		if Input.is_action_pressed("move_backward"):
			direction += aim.z
		if Input.is_action_pressed("move_left"):
			direction -= aim.x
		if Input.is_action_pressed("move_right"):
			direction += aim.x
		direction.y = 0

		direction = direction.normalized()

		if direction.length() > 0:
			direction += aim.z.normalized() * drunk_effect_x() * .1 * PlayerStats.alcohol
			direction += aim.x.normalized() * drunk_effect_z() * .05 * PlayerStats.alcohol
		
		direction = direction.normalized()
				
		var target = direction * FLY_SPEED
		var oldy = velocity.y
		velocity = velocity.linear_interpolate(target, FLY_ACCELL * delta)
		if not(is_on_floor()) :
			velocity.y = oldy - 9.8 * delta
		move_and_slide(velocity, Vector3(0,1,0))
		
		if velocity.length() > 4:
			if not $CollisionShape/AudioStreamPlayer3D.playing:
				$CollisionShape/AudioStreamPlayer3D.play()
		else:
			$CollisionShape/AudioStreamPlayer3D.stop()
		
		p += delta
		rotate_x(drunk_effect_x() * .005 * delta * PlayerStats.alcohol)
		rotate_y(drunk_effect_y() * .002 * delta * PlayerStats.alcohol)
		rotate_z(drunk_effect_z() * .01 * delta * PlayerStats.alcohol)
		$Head/Camera.fov = 70 + sin(2 * p) * 1 * delta * PlayerStats.alcohol
		
func drunk_effect_x():
	return sin(1.1*p + 3.14 * .5)
	
func drunk_effect_y():
	return sin(.7*p + 3.14 * .5)

func drunk_effect_z():
	return sin(1.3*p + 3.14 * .5)
	
func _on_PlayerStats_vomit():
	$Head/AnimationPlayer.play("Vomit")
