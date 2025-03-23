extends RigidBody2D


func _ready() -> void:
	##生成时随机选择三个动画中的其中一个
	var mob_types=Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation=mob_types.pick_random()


##当mob离开屏幕范围时销毁自己
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
