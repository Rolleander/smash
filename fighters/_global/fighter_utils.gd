extends Node

func parent_fighter(node: Node) -> Fighter:
	var current = node
	while current != null:
		if current is Fighter:
			return current
		current = current.get_parent()
	return null
