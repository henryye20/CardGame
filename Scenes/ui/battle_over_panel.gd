class_name BattleOverPanel
extends Panel

const MENU := preload("res://Scenes/ui/main_menu.tscn") as PackedScene
enum Type{WIN,LOSE}

@onready var label: Label = %Label
@onready var restart_button = %RestartButton
@onready var continue_button = %ContinueButton

func _ready() ->void:
	continue_button.pressed.connect(func(): Events.battle_won.emit())
	restart_button.pressed.connect(func():get_tree().change_scene_to_packed(MENU))
	Events.battle_over_screen_requested.connect(show_screen)


func show_screen(text:String,type:Type) ->void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true
