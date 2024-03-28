class_name Tooltip
extends PanelContainer

@export var fadetime := 0.2

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_text_label: RichTextLabel = %TooltipText

var tween: Tween

func _ready() -> void:
	Events.card_tooltip_requested.connect(show_tooltip)
	Events.tooltip_hide_requested.connect(hide_tooltip)
	modulate = Color.TRANSPARENT
	hide()
	
func show_tooltip(icon:Texture,text:String) -> void:
	#prevents multiple tooltips at once
	if tween:
		tween.kill()
		
	tooltip_icon.texture = icon
	tooltip_text_label.text = text
	
	tween = create_tween()
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE,fadetime)
	
func hide_tooltip() -> void:
	if tween:
		tween.kill()
	hide_animation()
	
func hide_animation() -> void:
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, fadetime)
	tween.tween_callback(hide)
