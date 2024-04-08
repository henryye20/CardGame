#meta-name: Card Logic
#meta-description: What happens when a card is played

extends Card

@export var optional_sound: AudioStream

func apply_effects(targets:Array[Node]) -> void:
	print("card played")
	print("targets:%s" % targets)