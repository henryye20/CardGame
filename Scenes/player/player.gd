class_name Player
extends Node2D

const WHITE_SPRITE_MATERIAL := preload("res://art/white_sprite_material.tres")

@export var stats: CharacterStats: 
	set = set_character_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI as StatsUI
var shake_strength := 16

func set_character_stats(value: CharacterStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		update_player()
		
		
func update_player() -> void:
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	update_stats()
	
func update_stats() -> void:
	stats_ui.update_stats(stats)

func take_damage(damage:int) -> void:
	if stats.health <= 0:
		return
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	
	if(damage<10):
		shake_strength = 8
	elif(damage<15):
		shake_strength = 16
	elif(damage>=15):
		shake_strength = 30
	tween.tween_callback(Shaker.shake.bind(self,shake_strength,0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.17)
	tween.finished.connect(
		func():
			
			sprite_2d.material = null
			if stats.health <= 0:
				Events.player_died.emit()
				queue_free()
	)
