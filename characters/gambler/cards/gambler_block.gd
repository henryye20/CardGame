extends Card

signal intern_summoned
func apply_effects(targets:Array[Node]) -> void:
	intern_summoned.emit()
	var block_effect := BlockEffect.new()
	block_effect.amount = 5
	block_effect.sound = sound
	block_effect.execute(targets)
