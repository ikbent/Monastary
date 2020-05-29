extends Particles

const STRENGTH_DECAY = .005
const SPEED = 20
var target
var attacking = false
var flytime
var strength
var origin
var dist
signal hit_by_sin(strength)

func attack(target, max_strength):
	var target_loc = target.global_transform.origin
	origin = self.global_transform.origin
	flytime = (target_loc - origin).length() / SPEED
	strength = max_strength
	attacking = true
	self.target = target
	dist = 0

func _physics_process(delta):
	if attacking:
		strength = strength - (STRENGTH_DECAY * delta)
		if (strength < 0):
			print("lost my strength")
			cancel_attack()
		else:
			dist += delta / flytime
			if dist > 1:
				dist = 1
			var newloc = origin + ((target.global_transform.origin - origin) * dist)
			global_transform.origin = newloc
			if dist == 1:
				cancel_attack()
				emit_signal("hit_by_sin", strength)
				print("wham")

func cancel_attack():
	emitting = false
	attacking = false
	get_parent().remove_child(self)
