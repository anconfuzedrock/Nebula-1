/obj/structure/grille
	name = "grille"
	desc = "A flimsy lattice of rods, with screws to secure it to the floor."
	icon = 'icons/obj/structures/grille.dmi'
	icon_state = "grille"
	density = 1
	anchored = 1
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	layer = BELOW_OBJ_LAYER
	explosion_resistance = 1
	rad_resistance_modifier = 0.1
	color = COLOR_STEEL
	material = /decl/material/solid/metal/steel
	parts_type = /obj/item/stack/material/rods
	parts_amount = 2

	handle_generic_blending = TRUE
	material_alteration = MAT_FLAG_ALTERATION_COLOR | MAT_FLAG_ALTERATION_NAME
	maxhealth = 20

	var/destroyed = 0
	var/list/connections
	var/list/other_connections

/obj/structure/grille/clear_connections()
	connections = null
	other_connections = null

/obj/structure/grille/get_material_health_modifier()
	. = (1/15)

/obj/structure/grille/set_connections(dirs, other_dirs)
	connections = dirs_to_corner_states(dirs)
	other_connections = dirs_to_corner_states(other_dirs)

/obj/structure/grille/update_material_desc(override_desc)
	if(material)
		desc = "A lattice of [material.solid_name] rods, with screws to secure it to the floor."
	else
		..()

/obj/structure/grille/Initialize()
	. = ..()
	if(!istype(material))
		. = INITIALIZE_HINT_QDEL
	if(. != INITIALIZE_HINT_QDEL)
		. = INITIALIZE_HINT_LATELOAD

/obj/structure/grille/LateInitialize()
	..()
	update_connections(1)
	update_icon()

/obj/structure/grille/explosion_act(severity)
	..()
	if(!QDELETED(src))
		physically_destroyed()

/obj/structure/grille/on_update_icon()
	..()
	var/on_frame = is_on_frame()
	overlays.Cut()
	if(destroyed)
		if(on_frame)
			icon_state = "broke_onframe"
		else
			icon_state = "broken"
	else
		var/image/I
		icon_state = ""
		if(on_frame)
			for(var/i = 1 to 4)
				var/conn = connections ? connections[i] : "0"
				if(other_connections && other_connections[i] != "0")
					I = image(icon, "grille_other_onframe[conn]", dir = 1<<(i-1))
				else
					I = image(icon, "grille_onframe[conn]", dir = 1<<(i-1))
				overlays += I
		else
			for(var/i = 1 to 4)
				var/conn = connections ? connections[i] : "0"
				if(other_connections && other_connections[i] != "0")
					I = image(icon, "grille_other[conn]", dir = 1<<(i-1))
				else
					I = image(icon, "grille[conn]", dir = 1<<(i-1))
				overlays += I

/obj/structure/grille/Bumped(atom/user)
	if(ismob(user)) shock(user, 70)

/obj/structure/grille/attack_hand(mob/user)

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	playsound(loc, 'sound/effects/grillehit.ogg', 80, 1)
	user.do_attack_animation(src)

	var/damage_dealt = 1
	var/attack_message = "kicks"
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))
			attack_message = "mangles"
			damage_dealt = 5

	if(shock(user, 70))
		return

	if(MUTATION_HULK in user.mutations)
		damage_dealt += 5
	else
		damage_dealt += 1

	attack_generic(user,damage_dealt,attack_message)

/obj/structure/grille/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover) && mover.checkpass(PASS_FLAG_GRILLE))
		return 1
	else
		if(istype(mover, /obj/item/projectile))
			return prob(30)
		else
			return !density

/obj/structure/grille/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)	return

	//Flimsy grilles aren't so great at stopping projectiles. However they can absorb some of the impact
	var/damage = Proj.get_structure_damage()
	var/passthrough = 0

	if(!damage) return

	//20% chance that the grille provides a bit more cover than usual. Support structure for example might take up 20% of the grille's area.
	//If they click on the grille itself then we assume they are aiming at the grille itself and the extra cover behaviour is always used.
	switch(Proj.damage_type)
		if(BRUTE)
			//bullets
			if(Proj.original == src || prob(20))
				Proj.damage *= between(0, Proj.damage/60, 0.5)
				if(prob(max((damage-10)/25, 0))*100)
					passthrough = 1
			else
				Proj.damage *= between(0, Proj.damage/60, 1)
				passthrough = 1
		if(BURN)
			//beams and other projectiles are either blocked completely by grilles or stop half the damage.
			if(!(Proj.original == src || prob(20)))
				Proj.damage *= 0.5
				passthrough = 1

	if(passthrough)
		. = PROJECTILE_CONTINUE
		damage = between(0, (damage - Proj.damage)*(Proj.damage_type == BRUTE? 0.4 : 1), 10) //if the bullet passes through then the grille avoids most of the damage

	take_damage(damage*0.2)

/obj/structure/grille/proc/cut_grille()
	playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
	if(destroyed)
		qdel(src)
	else
		set_density(0)
		if(material)
			material.create_object(get_turf(src), 1, parts_type)
		destroyed = TRUE
		parts_amount = 1
		update_icon()

/obj/structure/grille/attackby(obj/item/W, mob/user)
	if(isWirecutter(W))
		if(!material.conductive || !shock(user, 100))
			cut_grille()

	else if((isScrewdriver(W)) && (istype(loc, /turf/simulated) || anchored))
		if(!shock(user, 90))
			playsound(loc, 'sound/items/Screwdriver.ogg', 100, 1)
			anchored = !anchored
			user.visible_message(SPAN_NOTICE("[user] [anchored ? "fastens" : "unfastens"] the grille."), \
								 SPAN_NOTICE("You have [anchored ? "fastened the grille to" : "unfastened the grill from"] the floor."))
			update_connections(1)
			update_icon()
			return

//window placing
	else if(istype(W,/obj/item/stack/material))
		var/obj/item/stack/material/ST = W
		if(ST.material.opacity > 0.7)
			return 0

		var/dir_to_set = 5
		if(!is_on_frame())
			if(loc == user.loc)
				dir_to_set = user.dir
			else
				dir_to_set = get_dir(loc, user)
				if(dir_to_set & (dir_to_set - 1)) //Only works for cardinal direcitons, diagonals aren't supposed to work like this.
					to_chat(user, "<span class='notice'>You can't reach.</span>")
					return
		place_window(user, loc, dir_to_set, ST)
		return

	else if(!(W.obj_flags & OBJ_FLAG_CONDUCTIBLE) || !shock(user, 70))
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		user.do_attack_animation(src)
		playsound(loc, 'sound/effects/grillehit.ogg', 80, 1)
		switch(W.damtype)
			if("fire")
				take_damage(W.force)
			if("brute")
				take_damage(W.force * 0.1)
	..()

/obj/structure/grille/physically_destroyed(var/skip_qdel)
	SHOULD_CALL_PARENT(FALSE)
	if(!destroyed)
		visible_message(SPAN_DANGER("\The [src] falls to pieces!"))
	cut_grille()
	. = TRUE

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise
/obj/structure/grille/proc/shock(mob/user, prb)
	if(!anchored || destroyed)		// anchored/destroyed grilles are never connected
		return 0
	if(!(material.conductive))
		return 0
	if(!prob(prb))
		return 0
	if(!in_range(src, user))//To prevent TK and exosuit users from getting shocked
		return 0
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src))
			if(C.powernet)
				C.powernet.trigger_warning()
			spark_at(src, cardinal_only = TRUE)
			if(HAS_STATUS(user, STAT_STUN))
				return 1
		else
			return 0
	return 0

/obj/structure/grille/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!destroyed)
		if(exposed_temperature > material.melting_point)
			take_damage(1)
	..()

// Used in mapping to avoid
/obj/structure/grille/broken
	destroyed = 1
	icon_state = "broken"
	density = 0

/obj/structure/grille/broken/Initialize()
	. = ..()
	take_damage(rand(1, 5)) //In the destroyed but not utterly threshold.

/obj/structure/grille/cult
	name = "cult grille"
	desc = "A matrice built out of an unknown material, with some sort of force field blocking air around it."
	material = /decl/material/solid/stone/cult

/obj/structure/grille/cult/CanPass(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group)
		return 0 //Make sure air doesn't drain
	..()

/obj/structure/grille/proc/is_on_frame()
	if(locate(/obj/structure/wall_frame) in loc)
		return TRUE

/proc/place_grille(mob/user, loc, obj/item/stack/material/rods/ST)
	if(ST.in_use)
		return
	if(ST.get_amount() < 2)
		to_chat(user, SPAN_WARNING("You need at least two rods to do this."))
		return
	user.visible_message(SPAN_NOTICE("\The [user] begins assembling a [ST.material.solid_name] grille."))
	if(do_after(user, 1 SECOND, ST) && ST.use(2))
		var/obj/structure/grille/F = new(loc, ST.material.type)
		user.visible_message(SPAN_NOTICE("\The [user] finishes building \a [F]."))
		F.add_fingerprint(user)
