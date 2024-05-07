extends EditorInspectorPlugin

func _can_handle(object):
	return true

var current

func _parse_begin(object):
	var btn: Button = Button.new()
	btn.text = "copy @onready"
	btn.pressed.connect(_on_button_pressed)
	current = object

	add_custom_control(btn)


func _on_button_pressed():
	var name = current.name.to_snake_case()
	var cls_name = current.get_class()
	var path = current.owner.get_path_to(current)
	var s = '@onready var %s: %s = $%s' % [name, cls_name, path]
	DisplayServer.clipboard_set(s)
