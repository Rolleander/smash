extends Node

func getFighters() -> Array[Fighter]:
	var node = get_tree().get_first_node_in_group("fighters_node")
	var fighters :  Array[Fighter] = []
	for n in node.get_children():
		fighters.append(n as Fighter)
	return fighters
