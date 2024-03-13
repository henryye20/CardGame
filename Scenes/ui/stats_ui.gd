class_name StatsUI
extends HBoxContainer

@onready var block: HBoxContainer = $Block
@onready var block_label: Label = %BlockLabel
@onready var health: HBoxContainer = $Health
@onready var health_label: Label = %HealthLabel

func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health_label.text = str(stats.health)
	
	# only displays the labels if the block/health is greater than 0
	block.visible = stats.block > 0
	health.visible = stats.health > 0
