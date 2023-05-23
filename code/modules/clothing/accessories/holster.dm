/obj/item/clothing/accessory/holster
	name = "shoulder holster"
	desc = "A handgun holster."
	icon_state = "holster"
	slot = "utility"
	matter = list(MATERIAL_BIOMATTER = 5)
	price_tag = 200
	spawn_blacklisted = FALSE
	spawn_frequency = 10
	rarity_value = 10
	spawn_tags = SPAWN_TAG_HOLSTER
	var/obj/item/holstered
	var/sound_in = 'sound/effects/holster/holsterin.ogg' //Occulus edit
	var/sound_out = 'sound/effects/holster/holsterout.ogg' //Occulus edit

/obj/item/clothing/accessory/holster/proc/holster(obj/item/I, mob/living/user)

	if(holstered && istype(user))
		to_chat(user, SPAN_WARNING("There is already \a [holstered] holstered here!"))
		return

	if(istype(src, /obj/item/clothing/accessory/holster/sword)) //Occulus edit start

		if (!(istype(I, /obj/item/tool/sword)))
			to_chat(user, SPAN_WARNING("[I] won't fit in [src]!"))
			return
	else  //Occulus edit finish

		if (!(I.slot_flags & SLOT_HOLSTER))
			to_chat(user, SPAN_WARNING("[I] won't fit in [src]!"))
			return

	holstered = I
	user.drop_from_inventory(holstered)
	holstered.loc = src
	holstered.add_fingerprint(user)
	w_class = max(w_class, holstered.w_class)
	user.visible_message(SPAN_NOTICE("[user] holsters \the [holstered]."), SPAN_NOTICE("You holster \the [holstered]."))
	playsound(user, "[sound_in]", 75, 0)  //Occulus edit
	name = "occupied [initial(name)]"

/obj/item/clothing/accessory/holster/proc/clear_holster()
	holstered = null
	name = initial(name)

/obj/item/clothing/accessory/holster/proc/unholster(mob/user as mob)
	if(!holstered)
		return

	if(istype(user.get_active_hand(),/obj))
		to_chat(user, SPAN_WARNING("You need an empty hand to draw \the [holstered]!"))
	else
		playsound(user, "[sound_out]", 75, 0)  //Occulus edit
		if(user.a_intent == I_HURT)
			usr.visible_message(
				SPAN_DANGER("[user] draws \the [holstered], ready to fight!"),  //Occulus edit
				SPAN_WARNING("You draw \the [holstered], ready to fight!")  //Occulus edit
				)
		else
			user.visible_message(
				SPAN_NOTICE("[user] draws \the [holstered], pointing it at the ground."),
				SPAN_NOTICE("You draw \the [holstered], pointing it at the ground.")
				)
		if(!user.put_in_active_hand(holstered)) //Occulus Edit: If your primary hand is full, draw with your offhand
			user.put_in_inactive_hand(holstered) //Occulus Edit: Prevents guns from getting deleted with hotkeys.
		holstered.add_fingerprint(user)
		w_class = initial(w_class)
		clear_holster()

/obj/item/clothing/accessory/holster/attack_hand(mob/user as mob)
	if (has_suit)	//if we are part of a suit
		if (holstered)
			unholster(user)
		return

	..(user)

/obj/item/clothing/accessory/holster/attackby(obj/item/W as obj, mob/user as mob)
	holster(W, user)

/obj/item/clothing/accessory/holster/emp_act(severity)
	if (holstered)
		holstered.emp_act(severity)
	..()

/obj/item/clothing/accessory/holster/examine(mob/user)
	..(user)
	if (holstered)
		to_chat(user, "A [holstered] is holstered here.")
	else
		to_chat(user, "It is empty.")

/obj/item/clothing/accessory/holster/on_attached(obj/item/clothing/under/S, mob/user as mob)
	..()
	has_suit.verbs += /obj/item/clothing/accessory/holster/verb/holster_verb

/obj/item/clothing/accessory/holster/on_removed(mob/user as mob)
	has_suit.verbs -= /obj/item/clothing/accessory/holster/verb/holster_verb
	..()

//For the holster hotkey
/obj/item/clothing/accessory/holster/verb/holster_verb()
	set name = "Holster"
	set category = "Object"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.stat)
		return

	//can't we just use src here?
	var/obj/item/clothing/accessory/holster/H = null
	if (istype(src, /obj/item/clothing/accessory/holster))
		H = src
	else if (istype(src, /obj/item/clothing/under))
		var/obj/item/clothing/under/S = src
		if (S.accessories.len)
			H = locate() in S.accessories

	if (!H)
		to_chat(usr, SPAN_WARNING("Something is very wrong."))

	if(!H.holstered)
		var/obj/item/W = usr.get_active_hand()
		if(!istype(W, /obj/item))
			to_chat(usr, SPAN_WARNING("You need your weapon equipped to holster it."))  //Occulus edit
			return
		H.holster(W, usr)
	else
		H.unholster(usr)

/obj/item/clothing/accessory/holster/armpit
	name = "armpit holster"
	desc = "A worn-out handgun holster. Perfect for concealed carry."
	icon_state = "holster"

/obj/item/clothing/accessory/holster/waist
	name = "waist holster"
	desc = "A handgun holster. Made of expensive leather."
	icon_state = "holster"
	overlay_state = "holster_low"

/obj/item/clothing/accessory/holster/hip
	name = "hip holster"
	desc = "A handgun holster slung low on the hip, draw pardner!"
	icon_state = "holster_hip"
