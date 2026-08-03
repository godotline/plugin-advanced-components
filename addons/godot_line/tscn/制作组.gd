@tool
extends Control


func _ready() -> void:
	var tree: Tree = $Tree
	tree.set_column_title(0, "制作人员")
	var root: TreeItem = tree.create_item()

	var authors: TreeItem = tree.create_item()
	authors.set_text(0, "0 制作人员")

	var description: TreeItem = tree.create_item()
	description.set_text(0, "1.1 基础说明")

	var author_item: TreeItem = tree.create_item(authors)
	author_item.set_text(0, "睦蕴shinn、Meny233")

	var description_item: TreeItem = tree.create_item(description)
	description_item.set_text(0, "作用于 GodotLine 模板项目的附加插件，不能独立添加到普通新项目。")
