@tool
extends "res://addons/godot_line/component_panel.gd"

const PLAYER_SCENE_PATH: String = "res://#Template/Player.tscn"
const ROAD_PAVER_SCRIPT_PATH: String = "res://#Template/[Scripts]/Level/RoadPaver.gd"
const GROUND_SCENE_PATH: String = "res://#Template/Ground.tscn"
const OBSTACLE_SCENE_PATH: String = "res://#Template/Obstacle.tscn"
const PYRAMID_SCENE_PATH: String = "res://#Template/Pyramid.tscn"
const CRYSTAL_SCENE_PATH: String = "res://#Template/Crystal.tscn"
const GUIDANCE_BOX_SCENE_PATH: String = "res://#Template/[Resources]/GuidanceBox.tscn"
const GEM_SCENE_PATH: String = "res://#Template/Gem.tscn"
const CROWN_CHECKPOINT_SCENE_PATH: String = "res://#Template/CrownCheckPoint.tscn"
const HEART_CHECKPOINT_SCENE_PATH: String = "res://#Template/HeartCheckPoint.tscn"
const FAKE_PLAYER_SCENE_PATH: String = "res://#Template/FakePlayer.tscn"
const JUMP_SCRIPT_PATH: String = "res://#Template/[Scripts]/Trigger/Jump.gd"
const TELEPORT_SCRIPT_PATH: String = "res://#Template/[Scripts]/Trigger/Teleport.gd"
const CHANGE_DIRECTION_SCRIPT_PATH: String = "res://#Template/[Scripts]/Trigger/ChangeDirection.gd"


func _on_player_pressed() -> void:
	add_scene(PLAYER_SCENE_PATH, "Player")


func _on_road_paver_pressed() -> void:
	var ground_scene: PackedScene = load(GROUND_SCENE_PATH) as PackedScene
	add_script_node(ROAD_PAVER_SCRIPT_PATH, "RoadPaver", {"base_floor": ground_scene})


func _on_ground_pressed() -> void:
	add_scene(GROUND_SCENE_PATH, "Ground")


func _on_obstacle_pressed() -> void:
	add_scene(OBSTACLE_SCENE_PATH, "Obstacle")


func _on_pyramid_pressed() -> void:
	add_scene(PYRAMID_SCENE_PATH, "Pyramid")


func _on_crystal_pressed() -> void:
	add_scene(CRYSTAL_SCENE_PATH, "Crystal")


func _on_guidance_box_pressed() -> void:
	add_scene(GUIDANCE_BOX_SCENE_PATH, "GuidanceBox")


func _on_gem_pressed() -> void:
	add_scene(GEM_SCENE_PATH, "Gem")


func _on_crown_checkpoint_pressed() -> void:
	add_scene(CROWN_CHECKPOINT_SCENE_PATH, "CrownCheckPoint")


func _on_heart_checkpoint_pressed() -> void:
	add_scene(HEART_CHECKPOINT_SCENE_PATH, "HeartCheckPoint")


func _on_fake_player_pressed() -> void:
	add_scene(FAKE_PLAYER_SCENE_PATH, "FakePlayer")


func _on_jump_pressed() -> void:
	add_trigger_component(JUMP_SCRIPT_PATH, "Jump")


func _on_teleport_pressed() -> void:
	add_trigger_component(TELEPORT_SCRIPT_PATH, "Teleport")


func _on_change_direction_pressed() -> void:
	add_trigger_component(CHANGE_DIRECTION_SCRIPT_PATH, "ChangeDirection")
