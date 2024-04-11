extends Node

var signal_timeout = 1.0

func _ready(): 
	send_signals()
	
func send_signals(): 
	pass
	#while true:
		#await get_tree().create_timer(signal_timeout).timeout
		#get_tree().call_group("EnemyUnit", "scan_for_target")
		

#func scan_for_target(): 
	#return
	#if state != "Patrol": return 
	#for group in attack_targets: 
			#for unit in get_tree().get_nodes_in_group(group): 
				#if global_transform.origin.distance_to(unit.global_transform.origin) < vision_distance: 
					#target = unit 
					#return 
