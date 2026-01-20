extends Control

@export var texture : AtlasTexture
@export var npc_words : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/TextureRect.texture = self.texture
	$HBoxContainer/Label.text = npc_words
