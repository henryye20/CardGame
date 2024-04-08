extends Control

const RUN_SCENE = preload("res://Scenes/run/run.tscn")
const BATTLE_SCENE = preload("res://Scenes/battle/battle.tscn")
const RICHPERSON_STATS := preload("res://characters/gambler/gambler.tres")

@export var run_startup: RunStartup

@onready var title = %Title
@onready var description = %Description
@onready var character_portait = $"Character Portait"


var current_character: CharacterStats : set = set_current_character


func _ready():
	set_current_character(RICHPERSON_STATS)
	
func _on_start_button_pressed():
	print("Start new run with %s"% current_character.character_name)
	run_startup.type = RunStartup.Type.NEW_RUN
	run_startup.picked_character = current_character
	get_tree().change_scene_to_packed(BATTLE_SCENE)
	
func _on_rich_person_button_pressed():
	current_character = RICHPERSON_STATS


func _on_other_button_pressed():
	pass # Replace with function body.


func _on_other_button_2_pressed():
	pass # Replace with function body.


func set_current_character(new_character:CharacterStats) -> void:
	current_character = new_character
	title.text = current_character.description
	description.text = current_character.character_name
	character_portait.texture = current_character.portrait

