extends Card


func apply_effects(targets:Array[Node]):
	Events.gamble_played.emit()

