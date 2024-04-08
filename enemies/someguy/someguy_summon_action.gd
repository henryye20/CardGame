extends EnemyAction
@export var hp_threshold := -1

var already_used := false
var someguy := preload("res://enemies/someguy/someguy.tscn")

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	
	return is_low

func perform_action() -> void:
	#code breaks idk why : D
	#var new_guy = someguy.instantiate()
	#new_guy.add_to_group("enemies")
	#get_tree().get_first_node_in_group("enemyhandler").add_child(new_guy)
	print("Summon")
	Events.enemy_action_completed.emit(enemy)
