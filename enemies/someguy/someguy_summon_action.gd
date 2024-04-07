extends EnemyAction
#not tutorial code :D
@export var hp_threshold := 5

var already_used := false


func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	
	return is_low

func perform_action() -> void:
	print("Summon")
	Events.enemy_action_completed.emit(enemy)
