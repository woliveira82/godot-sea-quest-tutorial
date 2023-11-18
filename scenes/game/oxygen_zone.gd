extends Area2D


func _on_area_entered(area):
	if area.is_in_group("Player"):
		if Global.saved_people_count >= 7:
			GameEvents.emit_signal("full_crew_oxygen_refuel")
			
		else:
			GameEvents.emit_signal("full_crew_oxygen_refuel")
