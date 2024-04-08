extends EnemyAction
#not tutorial code :D
@export var hp_threshold := 5

var already_used := false
const someguy := preload("res://Scenes/enemy/enemy.tscn")

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	
	return is_low

func perform_action() -> void:
	#var new_guy = someguy.instantiate()
	#new_guy.add_to_group("enemies")
	#get_tree().get_first_node_in_group("enemyhandler").add_child(new_guy)
	print("Summon")
	Events.enemy_action_completed.emit(enemy)
