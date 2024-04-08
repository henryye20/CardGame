#meta-name: Effect
#meta-description: create an efffect which can be applied to a target.

class_name MyEffectName
extends Effect

var member_var := 0


func execute(targets: Array[Node]) -> void:
	print("My effect targets: %s" % targets)
	print("it does %s something" % member_var)
	SFXPlayer.play(sound)
