extends Node

@export var mob_scene:PackedScene#加载Mob
var score


func _ready() -> void:
	pass

func _on_player_hit() -> void:
	game_over()

	
func game_over():
	$Timer_ScoreTimer.stop()
	$Timer_Mob.stop()
	$HUD.show_game_over()
	
func new_game():
	score=0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$Timer_StartTimer.start()
	get_tree().call_group("mobs","queue_free")


func _on_timer_mob_timeout() -> void:
	var mob=mob_scene.instantiate()
	var mob_spawn_location=$Mob_Path/Mob_Spawn_Location
	mob_spawn_location.progress_ratio=randf()#在路径上的随机位置生成敌人
	mob.position=mob_spawn_location.position
	
	var direction=mob_spawn_location.rotation+PI/2
	direction+=randf_range(-PI/4,PI/4)
	mob.rotation=direction
	
	var velocity=Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity=velocity.rotated(direction)
	
	add_child(mob)


func _on_timer_score_timer_timeout() -> void:
	score+=1
	$HUD.update_score(score)


func _on_timer_start_timer_timeout() -> void:
	$Timer_Mob.start()
	$Timer_ScoreTimer.start()
