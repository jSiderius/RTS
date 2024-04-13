Author: 	Josh Siderius
Date: 		2024-03-17
Class: 		COMP 4501
Assignment:	Project

Didn't get to accoplish everything I wanted but I am done for now at least, I will probably pick it up at somepoint and finish
	- Add unit wait times and queues when purchasing
	- Make unit purchases spend cash 
	- Power-ups have AOE
	- Switch earlier code to better conventions (polymorphism, triggers)
	- Player units search for targets just like enemy units
	- Audio 
	- Minimap
	- Visible bullets
	- Bug fix
	- Playtest and manufature the game experience
	- Optimization
	
Overall I think I overextended myself with features functionality and design, I definitely could have had a much simpler but complete game
Also the editor uses quite alot of RAM on the game and terrain scenes so don't have those open as much as possible
Message me if you have any problems grading  
Also the assets are not mine and I'm not claiming any credit for them other than manipulating them in the editor 

Report: 

The mechanics of the game are as follows
	- The play is capable of using the UI to purchase buildings and units in the game
	- The buildings and units cost money and can also cost or give power
	- The headquarters building is the home base and if destroyed (Not currently implemented because bugs) the game is over
	- The Power plants give access to more power for buildings
	- The refinery gives trucks which can go into the world and collect resources
	- The quarters allow unit spawing
	- The factories allow truck unit spawning
	- The airports allow air unit spawning
	- The nuclear plant is an alternate end condition
	- The units on the player side can be manipulated by
		- Drag and select
		- Click and select
		- Shift drag or click and select (alt-select)
		- Right click to move
		- Right click on target (Collectable, Unit, Building) to target
	- The resoruce truck works as follows
		- Select and send to resource
		- On collision with resource, picks it up and naturally returns to base
		- On death, respawns after a time period 
	- The GI works as follows
		- Can attack ground units and buildings
		- Can collect health and weapon upgrades
	- The tank and armoured car are attacking units with altered stats
	- Units in the world are patroling / defending units, they will patrol points, or fight units in range
	- You have to go to them to access resources
	- Units that spawn are storming units, they will charge the player base
	- This is the last thing I was working on and unfortunately it is in a decently buggy state
	- The airport will spawn units after about 3 minutes and the barracks after 1, but you can change this in their scripts
	- There's probably some other stuff I'm missing

I'll go over the checklist and where I would say each component is implemented
1: 
	- I presented on Thursday the 4th
2: 
	- The Nav mesh renders based on CollisionShape3D's
	- This way I can use masking to determine what bakes into the Nav Mesh
	- You can see base buildings and terrain baked into the mesh as obstacles while units and collectables are not
3: 
	- There are 8 units in my game and I added animation to 5 of them
	- The assets I have imported for the infantry unit and enemy infantry have animations attached
	- I implemented an animation tree and game logic to have them 
		- Attack / shoot
		- Walk + attack / shoot
		- Idle
		- Walk 
		- Take damage 
	- These 3 units were very similar and once the first was done the rest took minimal work
	- The helicopters were just an OBJ mesh
	- I split the mesh into rotor and body in Blender and re-imported to Godot
	- Then I just ported to meshs' to each unit and added constant rotation to the rotor
	- For the tank, armoured car, and resource truck I didn't feel animation was necessary because the movement of the mesh itself gives most of the animation
	- Anything else would just be tires spinning which is minimal and at the scale of the game would barely be noticed 
4: 
	- This is best implemented in the ResourceTruck, if you click on a resource on the map, it will get the resource then target its home base and cash the resource in 
	- The turrets will also auto-detect units in their range and attack
5: 
	- Units can  be patroling units or storming units. 
	- Patrolling units will alternate between patrol, chase, chase and attack, stop and attack
	- Storming units will alternate between storm base, chase, chase and attack, stop and attack
6 :
	- Most of the mechanics are there but I came up short on a full playable experience 
	- Units are placed around the map and gaurding resources 
	- The player has to fight the troops to gather resources and build better troops to storm the enemy base
	- The Enemy base spawns units faster over time which eventually could overcome the player base 
7: 
	- At least this is decent, UI and selection do a good job of explaining events
8: 
	- Seperate Air and Land navigation with different units being able to attack air, land, buildings
	- Collectables in the world with different effects
	- Unit spawners in the enemy base 
	- Ability to build 7 building types with different purposes
	- Power and money systems which tie into building and unit construction
	- Informative popups in the left hand corner informing why you may not be able to buy something 
	- 5 individual player units and 2 enemy units with unique stats


ASSIGNMENT 1 README 
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

 
