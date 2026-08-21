@tool
extends "res://addons/godot_line/component_panel.gd"

const CAMERA_TRIGGER_SCRIPT_PATH: String = "res://#Template/[Scripts]/Camera/CameraTrigger.gd"
const EVENT_TRIGGER_SCRIPT_PATH: String = "res://#Template/[Scripts]/Trigger/EventTrigger.gd"
const MOVING_POSITION_SCRIPT_PATH: String = "res://#Template/[Scripts]/Animator/MovingPosMax.gd"
const FAKE_PLAYER_TRIGGER_SCRIPT_PATH: String = "res://#Template/[Scripts]/Trigger/FakePlayerTrigger.gd"


func _on_trigger_pressed() -> void:
	add_scene(TRIGGER_SCENE_PATH, "Trigger")


func _on_camera_trigger_pressed() -> void:
	add_trigger_component(CAMERA_TRIGGER_SCRIPT_PATH, "CameraTrigger")


func _on_event_trigger_pressed() -> void:
	add_trigger_component(EVENT_TRIGGER_SCRIPT_PATH, "EventTrigger")


func _on_moving_position_pressed() -> void:
	add_trigger_component(MOVING_POSITION_SCRIPT_PATH, "MovingPosMax")


func _on_fake_player_trigger_pressed() -> void:
	add_trigger_component(FAKE_PLAYER_TRIGGER_SCRIPT_PATH, "FakePlayerTrigger")
