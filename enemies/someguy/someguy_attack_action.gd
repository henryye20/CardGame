extends EnemyAction

@export var damage:= 7


func perform_action() -> void:
	#checks for valid target
	if not enemy or not target:
		return
	#enemy animation
	var tween:= create_tween().set_trans(Tween.TRANS_QUINT)
	var start:= enemy.global_position
	#*32 is + 32 for vectors for some reason
	var end := target.global_position + Vector2.RIGHT * 32
	var damage_effect:= DamageEffect.new()
	var target_array: Array[Node] = [target]
	
	damage_effect.amount = damage
	
	
	tween.tween_property(enemy, "global_position", end, 1.0)
	tween.tween_property(enemy.sprite_2d,"rotation_degrees",360,.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.parallel().tween_property(enemy, "scale",Vector2(1.5,1.5),0.1)
	tween.tween_property(enemy, "scale",Vector2(1,1),0.1)
	
	
	tween.tween_interval(0.25)
	
	print("tweening")
	tween.tween_property(enemy,"global_position", start, 0.4)
	tween.tween_property(enemy.sprite_2d,"rotation_degrees",0,0)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
	
	
