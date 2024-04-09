extends Card

func apply_effects(targets:Array[Node]):
	Events.double_played.emit()

