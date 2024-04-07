class_name Tooltip
extends PanelContainer

@export var fadetime := 0.2

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_text_label: RichTextLabel = %TooltipText
@onready var tooltip_title: Label = %Label

var tween: Tween
var is_visible := true

func _ready() -> void:
	Events.card_tooltip_requested.connect(show_tooltip)
	Events.tooltip_hide_requested.connect(hide_tooltip)
	
	
	modulate = Color.TRANSPARENT
	hide()
	
func show_tooltip(icon:Texture,text:String,name:String) -> void:
	#prevents multiple tooltips at once
	is_visible = true
	if tween:
		tween.kill()
		
	tooltip_icon.texture = icon
	tooltip_text_label.text = text
	tooltip_title.text = name
	tween = create_tween()
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE,fadetime)
	
func hide_tooltip() -> void:
	is_visible = false
	if tween:
		tween.kill()
	get_tree().create_timer(fadetime, false).timeout.connect(hide_animation)
	hide_animation()
	
func hide_animation() -> void:
	#skips animation if player is fast to remove flashing weirdness
	if not is_visible:
		tween = create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fadetime)
		tween.tween_callback(hide)
