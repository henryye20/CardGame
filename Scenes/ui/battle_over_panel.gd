class_name BattleOverPanel
extends Panel

enum Type{WIN,LOSE}

@onready var label: Label = %Label
@onready var restart_button = %RestartButton
@onready var continue_button = %ContinueButton

func _ready() ->void:
	continue_button.pressed.connect(get_tree().quit)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	Events.battle_over_screen_requested.connect(show_screen)


func show_screen(text:String,type:Type) ->void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true
