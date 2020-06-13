/mob/living/exosuit/premade/light
	name = "light exosuit"
	desc = "A light and agile exosuit."

	material = MATERIAL_PLASTIC
	exosuit_color = COLOR_OFF_WHITE
	installed_armor = /obj/item/robot_parts/robot_component/armour/exosuit/radproof
	installed_software_boards = list(
		/obj/item/weapon/circuitboard/exosystem/utility,
		/obj/item/weapon/circuitboard/exosystem/medical
	)
	installed_systems = list(
		HARDPOINT_LEFT_HAND = /obj/item/mech_equipment/catapult,
		HARDPOINT_BACK = /obj/item/mech_equipment/sleeper,
		HARDPOINT_HEAD = /obj/item/mech_equipment/light,
	)

/mob/living/exosuit/premade/light/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/light(src)
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/light(src)
	if(!head)
		head = new /obj/item/mech_component/sensors/light(src)
	if(!body)
		body = new /obj/item/mech_component/chassis/light(src)

	. = ..()


/obj/item/mech_component/manipulators/light
	name = "light arms"
	exosuit_desc_string = "lightweight, segmented manipulators"
	icon_state = "light_arms"
	melee_damage = 5
	action_delay = 15
	max_damage = 40
	power_use = 10
	desc = "As flexible as they are fragile, these Vey-Med manipulators can follow a pilot's movements in close to real time."
	matter = list(MATERIAL_STEEL = 10)

/obj/item/mech_component/propulsion/light
	name = "light legs"
	exosuit_desc_string = "aerodynamic electromechanic legs"
	icon_state = "light_legs"
	move_delay = 2
	max_damage = 40
	power_use = 5
	desc = "The electrical systems driving these legs are almost totally silent. Unfortunately, slamming a plate of metal against the ground is not."
	matter = list(MATERIAL_STEEL = 10)

/obj/item/mech_component/sensors/light
	name = "light sensors"
	gender = PLURAL
	exosuit_desc_string = "advanced sensor array"
	icon_state = "light_head"
	max_damage = 30
	vision_flags = SEE_TURFS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	power_use = 50
	desc = "A series of high resolution optical sensors. They can overlay several images to give the pilot a sense of location even in total darkness."
	matter = list(MATERIAL_STEEL = 8)

/obj/item/mech_component/chassis/light
	name = "light exosuit chassis"
	hatch_descriptor = "canopy"
	pilot_coverage = 100
	transparent_cabin =  TRUE
	hide_pilot = TRUE //Sprite too small, legs clip through, so for now hide pilot
	exosuit_desc_string = "an open and light chassis"
	icon_state = "light_body"
	max_damage = 50
	power_use = 5
	has_hardpoints = list(HARDPOINT_BACK)
	desc = "The Veymed Odysseus series cockpits combine ultralight materials clear aluminum laminates to provide an optimized cockpit experience."
	matter = list(MATERIAL_STEEL = 30)

/obj/item/mech_component/chassis/light/Initialize()
	pilot_positions = list(
		list(
			"[NORTH]" = list("x" = 8,  "y" = -2),
			"[SOUTH]" = list("x" = 8,  "y" = -2),
			"[EAST]"  = list("x" = 1,  "y" = -2),
			"[WEST]"  = list("x" = 9,  "y" = -2)
		)
	)
	. = ..()
