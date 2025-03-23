extends Area2D

@export var speed=200
var screen_size
signal hit

func _ready() -> void:
	screen_size=get_viewport_rect().size#获取当前视口的大小
	hide()



func _process(delta: float) -> void:
	var velocity=Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
	if velocity.length()>0:
		velocity=velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	##更新玩家位置
	position+=velocity*delta
	position=position.clamp(Vector2.ZERO,screen_size)
	##动画控制
	if velocity.x!=0:#如果玩家在左右移动
		$AnimatedSprite2D.animation="walk"
		$AnimatedSprite2D.flip_v=false#左右移动禁用图像上下翻转
		$AnimatedSprite2D.flip_h=velocity.x<0#通过翻转图像实现左右看
	elif velocity.y!=0:
		$AnimatedSprite2D.animation="up"
		$AnimatedSprite2D.flip_v=velocity.y>0


#region 重置玩家函数
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false
#endregion

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)#合适的时候关闭这个collisionshape2d
