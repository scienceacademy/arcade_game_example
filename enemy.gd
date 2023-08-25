extends Area2D

var start_pos = Vector2.ZERO
var speed = 0

@onready var screensize = get_viewport_rect().size

func start(pos):
	speed = 0
	position = Vector2(pos.x, -pos.y)
	start_pos = pos
	await get_tree().create_timer(randf_range(0.25, 0.5)).timeout
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position:y", start_pos.y, 1.4)
	$MoveTimer.wait_time = randf_range(5, 20)
	$MoveTimer.start()
	$ShootTimer.wait_time = randf_range(5, 20)
	$ShootTimer.start()

func _on_move_timer_timeout():
	speed = randf_range(75, 100)

func _on_shoot_timer_timeout():
	pass # Replace with function body.
	
func _process(delta):
	position.y += speed * delta
	if position.y > screensize.y + 32:
		start(start_pos)

func explode():
	speed = 0
	$AnimationPlayer.play("explode")
	set_deferred("monitoring", false)
	await $AnimationPlayer.animation_finished
	queue_free()
