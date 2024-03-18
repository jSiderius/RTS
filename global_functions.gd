extends Node

# Global function to determine if a node is in one of several groups
func is_in_groups(node : Node, groups : Array[String]): 
	for group in groups: 
		if node.is_in_group(group): 
			return true
	return false
