class_name IntentUI
extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var number: Label = $Number


func update_intent(intent:Intent) -> void:
	if not intent:
		hide()
		return
	
	icon.texture = intent.icon
	
	#will not be displayed if it doesnt exist
	icon.visible = icon.texture !=null

	number.text = str(intent.number)
	number.visible = intent.number !=null
	show()
	
