extends CanvasLayer

@export var texture : AtlasTexture
@export var npc_words : String
@export var upgrade_stat : Upgrade
@onready var before : Label = $UpgradeOffer/VBoxContainer/HBoxContainer/Before
@onready var after : Label = $UpgradeOffer/VBoxContainer/HBoxContainer/After
@onready var picture : TextureRect = $UpgradeOffer/HBoxContainer/TextureRect
@onready var welcome : Label = $UpgradeOffer/HBoxContainer/Label

#var view : StatsDef

func _preview() -> void:
	var view = Stats.current_stats
	var value = upgrade_stat.apply(view)
	before.text = value[0] + ": " + str(value[1])
	after.text = value[0] + ": " + str(value[2])
	print("prewiew")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	picture.texture = self.texture
	welcome.text = npc_words
	_preview()

func _on_button_pressed() -> void:
	#Stats.current_stats = view
	Stats.upgrade()
	_preview()
