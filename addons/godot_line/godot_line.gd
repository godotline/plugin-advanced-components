@tool
extends EditorPlugin

const BASIC_COMPONENTS_SCENE: PackedScene = preload("res://addons/godot_line/tscn/基础组件.tscn")
const ADVANCED_COMPONENTS_SCENE: PackedScene = preload("res://addons/godot_line/tscn/高级自定义组件.tscn")
const CREDITS_SCENE: PackedScene = preload("res://addons/godot_line/tscn/制作组.tscn")

var _dock_controls: Array[Control] = []


func _enable_plugin() -> void:
	pass


func _disable_plugin() -> void:
	pass


func _enter_tree() -> void:
	_dock_controls = [
		BASIC_COMPONENTS_SCENE.instantiate() as Control,
		ADVANCED_COMPONENTS_SCENE.instantiate() as Control,
		CREDITS_SCENE.instantiate() as Control,
	]
	for control: Control in _dock_controls:
		if control:
			add_control_to_dock(DOCK_SLOT_RIGHT_BL, control)


func _exit_tree() -> void:
	for control: Control in _dock_controls:
		if is_instance_valid(control):
			remove_control_from_docks(control)
			control.queue_free()
	_dock_controls.clear()
