extends Sprite2D

var speed = 500  # pixels/sec

func _ready():
	position = Vector2(0, 400)

func _process(delta):
	position.x += speed * delta
