/obj/item/biosyphon
	name = "Lazarus Carbon Reclaimer"
	desc = "A vat of bluespace-enriched yeast that slowly produces donuts seemingly out of nowhere. LCR was generously donated to Aegis after one of the officers was hospitalized as a result of inhaling Lazarus' macroinsect repellant."
	icon = 'icons/obj/faction_item.dmi'
	icon_state = "biosyphon"
	item_state = "biosyphon"
	w_class = ITEM_SIZE_BULKY
	flags = CONDUCT
	throwforce = WEAPON_FORCE_PAINFUL
	throw_speed = 1
	throw_range = 2
	price_tag = 20000
	origin_tech = list(TECH_MATERIAL = 4, TECH_BLUESPACE = 8, TECH_POWER = 7)
	matter = list(MATERIAL_PLASTIC = 6, MATERIAL_GLASS = 7)
	spawn_frequency = 0
	spawn_blacklisted = TRUE
	var/last_produce = 0
	var/cooldown = 15 MINUTES

/obj/item/biosyphon/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/biosyphon/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/biosyphon/Process()
	if(world.time >= (last_produce + cooldown))
		var/obj/item/storage/box/donut/D = new /obj/item/storage/box/donut(src.loc)
		visible_message(SPAN_NOTICE("[name] dispenses [D]."))
		last_produce = world.time
