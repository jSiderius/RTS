Author: 	Josh Siderius
Date: 		2024-03-17
Class: 		COMP 4501
Assignment:	Project ProtoType

The code documentation is in the code so I'll just go over the features and high-level stuff

- I spent a good amount of my time on UI and base designing. Close to the proposal deadline I switched gears into unit and action base stuff because I realized the proposal revolves around it more
- The unit stuff is mostly set up and ready to be built into a working game (minus AI)
- You can click the buttons and the base spawns
- Each building has a function
	- HQ: End condition
	- Refinery: Send player controlled trucks to gather resources and gain money
	- Power Plant: Raises the energy limit which allows more buildings
	- Barracks: Allows for building troops
	- Factory: Allows for bulding vehicles (tanks, trucks)
	- Airport / Helipad: Allows for bulding helicopters given factory is built already
	- Nucler Plant: Creates a nuke which is an alternate end condition
	- Turrets: This button doesn't work yet but these will defend the base
- A bit of logic will tie whats already there into a working game
- The idea is that the player and AI fight for resources in the world with trucks, as well as health and damage buffs for soldiers while they build strength and overrun the other
Requirement Notes: 
- 2.2: 
	- Only light source that seemed necesary was a sun-like directional light node
	- Shadows face with the isometric view so they are noticable 
- 3.1: 
	- Spent a decent amount of time on world design but I ran into graphics issues where my editor would crash
	- You can see the original scene in terrain.tscn, but I am using simple_terrain.tscn for the prototype 
- 4: 
	- Some objects have collision like object to collectable
	- For the most part physics collisions are not necessary because I am handling movement with a Godot NavMesh
	- Units just traverse the mesh
- 6: 
	Unit Actions: 
	- Drag and select units
	- Click and select units
	- Infantry unit add health as target
	- Infantry unit collect health, gains HP 
	- Infantry unit add weapon box as target
	- Infantry unit collect weapon box, gain DPS
	- Infantry or tank select enemy unit or building as target
	- Infantry or tank attack enemy unit or target (if HQ is destroyed game over)
	- Resource truck select resource as target 
	- Resource truck collect resource (gains money) 
- 7: 
	- The camera moves by dragging the mouse to the edge of the screen

 