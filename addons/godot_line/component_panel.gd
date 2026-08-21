@tool
class_name GodotLineComponentPanel
extends Control

const TRIGGER_SCENE_PATH: String = "res://#Template/Trigger.tscn"

var _last_added_node: Node


func add_scene(scene_path: String, display_name: String) -> void:
	var packed_scene: PackedScene = load(scene_path) as PackedScene
	if not packed_scene:
		push_error("GodotLine: 无法加载场景 %s" % scene_path)
		return

	var node: Node = packed_scene.instantiate()
	if not node:
		push_error("GodotLine: 无法实例化场景 %s" % scene_path)
		return

	_add_node_to_scene(node, display_name)


func add_script_node(script_path: String, display_name: String, properties: Dictionary = {}) -> void:
	var script: Script = load(script_path) as Script
	if not script:
		push_error("GodotLine: 无法加载脚本 %s" % script_path)
		return

	var node: Node3D = Node3D.new()
	node.set_script(script)
	for property_name: Variant in properties:
		node.set(String(property_name), properties[property_name])

	_add_node_to_scene(node, display_name)


func add_trigger_component(script_path: String, display_name: String) -> void:
	var packed_scene: PackedScene = load(TRIGGER_SCENE_PATH) as PackedScene
	var script: Script = load(script_path) as Script
	if not packed_scene or not script:
		push_error("GodotLine: 无法加载触发器或组件 %s" % script_path)
		return

	var trigger: Node = packed_scene.instantiate()
	if not trigger:
		push_error("GodotLine: 无法实例化基础触发器")
		return

	var component: Node = trigger.get_node_or_null("Comp1")
	if not component:
		component = Node3D.new()
		component.name = "Comp1"
		trigger.add_child(component)
	component.set_script(script)
	component.name = _unique_child_name(trigger, display_name)
	_add_node_to_scene(trigger, display_name)


func _add_node_to_scene(node: Node, display_name: String) -> void:
	var scene_root: Node = EditorInterface.get_edited_scene_root()
	if not scene_root:
		push_warning("GodotLine: 请先打开一个可编辑的场景")
		node.queue_free()
		return

	var node_name: String = display_name if not display_name.is_empty() else String(node.name)
	node.name = _unique_child_name(scene_root, node_name)

	# 递归设置 owner：只对 owner 为空的节点（如 add_trigger_component 动态创建的
	# Comp1 子组件）赋值，保留 PackedScene 内嵌子场景节点原有的 owner，避免误内联嵌套实例。
	# 参考 addons/template/component_add_panel.gd 的 _add_component 逻辑。
	_own_subtree(node, scene_root)

	var undo_redo: EditorUndoRedoManager = EditorInterface.get_editor_undo_redo()
	if undo_redo:
		undo_redo.create_action("添加 " + display_name)
		undo_redo.add_do_method(scene_root, "add_child", node)
		undo_redo.add_undo_method(scene_root, "remove_child", node)
		undo_redo.add_do_reference(node)
		undo_redo.commit_action()
	else:
		scene_root.add_child(node)

	_last_added_node = node
	EditorInterface.mark_scene_as_unsaved()
	var selection: EditorSelection = EditorInterface.get_selection()
	selection.clear()
	selection.add_node(node)
	notify_property_list_changed()


func _own_subtree(node: Node, owner_root: Node) -> void:
	if node.owner == null:
		node.owner = owner_root
	for child: Node in node.get_children():
		_own_subtree(child, owner_root)


func _unique_child_name(parent: Node, requested_name: String) -> String:
	var base_name: String = requested_name if not requested_name.is_empty() else "Component"
	var candidate: String = base_name
	var suffix: int = 2
	while parent.get_node_or_null(NodePath(candidate)):
		candidate = "%s %d" % [base_name, suffix]
		suffix += 1
	return candidate
