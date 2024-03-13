extends Card


func apply_effects(targets:Array[Node]) -> void:
	var block_effect := BlockEffect.new()
	print("hg")
	block_effect.amount = 5
	block_effect.execute(targets)
