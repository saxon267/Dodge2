extends Sprite2D

const  MAX_LENTH:int=70#摇杆最大活动范围
var on_draging=-1

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var mouse_position=(event.position-self.global_position).length()
		if mouse_position<=MAX_LENTH or event.get_index()==on_draging:
			on_draging=event.get_index()
			$Joystick_rocker.set_global_position(event.position)
			
		$Joystick_rocker.set_global_position(event.position)
		if $Joystick_rocker.position.length()>MAX_LENTH:
			$Joystick_rocker.set_position($Joystick_rocker.position.normalized()*MAX_LENTH)
	if event is InputEventScreenTouch and !event.is_pressed():
		if event.get_index()==on_draging:
			set_center()
			on_draging=-1


func set_center():
	$Joystick_rocker.position=Vector2.ZERO

func get_now_position():
	return $Joystick_rocker.position.normalized()
