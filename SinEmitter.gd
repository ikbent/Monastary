extends Spatial

export var rate = .2
export var max_strength = 0.02
signal hit_by_sin(source, strength)
var player

var rng = RandomNumberGenerator.new()

const SinResource = preload("res://Sin.tscn")

func _ready():
	rng.randomize()
	

func set_player(player):
	self.player = player

func _process(delta):
	if rng.randf() < rate * delta:
		print("instantiating sin")
		var s = SinResource.instance()
		s.connect("hit_by_sin", self, "on_hit_by_sin")
		add_child(s)
		s.attack(player, max_strength)

func on_hit_by_sin(strength):
	print("Hit by sin ", strength)
	emit_signal("hit_by_sin", self, strength)
