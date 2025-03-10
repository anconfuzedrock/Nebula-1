/obj/random
	name = "random object"
	desc = "This item type is used to spawn random objects at round-start."
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything

	var/spawn_method = /obj/random/proc/spawn_item

// creates a new object and deletes itself
/obj/random/Initialize()
	..()
	call(src, spawn_method)()
	return INITIALIZE_HINT_QDEL

// creates the random item
/obj/random/proc/spawn_item()
	if(prob(spawn_nothing_percentage))
		return

	if(isnull(loc))
		return

	var/build_path = pickweight(spawn_choices())

	var/atom/A = new build_path(src.loc)
	if(pixel_x || pixel_y)
		A.pixel_x = pixel_x
		A.pixel_y = pixel_y

	return A

// Returns an associative list in format path:weight
/obj/random/proc/spawn_choices()
	return list()

/obj/random/single
	name = "randomly spawned object"
	desc = "This item type is used to randomly spawn a given object at round-start."
	icon_state = "x3"
	spawn_nothing_percentage = 50
	var/spawn_object = null

/obj/random/single/spawn_choices()
	return list(spawn_object)

/obj/random/tool
	name = "random tool"
	desc = "This is a random tool."
	icon = 'icons/obj/items/tool/welders/welder.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/tool/spawn_choices()
	return list(/obj/item/screwdriver,
				/obj/item/wirecutters,
				/obj/item/weldingtool,
				/obj/item/weldingtool/largetank,
				/obj/item/crowbar,
				/obj/item/wrench,
				/obj/item/flashlight)

/obj/random/technology_scanner
	name = "random scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/items/device/scanner/atmos_scanner.dmi'
	icon_state = "atmos"

/obj/random/technology_scanner/spawn_choices()
	return list(/obj/item/t_scanner = 5,
				/obj/item/radio = 2,
				/obj/item/scanner/gas = 5)

/obj/random/powercell
	name = "random powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "hcell"

/obj/random/powercell/spawn_choices()
	return list(/obj/item/cell/crap = 1,
				/obj/item/cell = 8,
				/obj/item/cell/high = 5,
				/obj/item/cell/super = 2,
				/obj/item/cell/hyper = 1,
				/obj/item/cell/device/standard = 7,
				/obj/item/cell/device/high = 5)

/obj/random/bomb_supply
	name = "bomb supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"

/obj/random/bomb_supply/spawn_choices()
	return list(/obj/item/assembly/igniter,
				/obj/item/assembly/prox_sensor,
				/obj/item/assembly/signaler,
				/obj/item/assembly/timer,
				/obj/item/multitool)

/obj/random/toolbox
	name = "random toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/items/storage/toolbox.dmi'
	icon_state = "red"

/obj/random/toolbox/spawn_choices()
	return list(/obj/item/storage/toolbox/mechanical = 30,
				/obj/item/storage/toolbox/electrical = 20,
				/obj/item/storage/toolbox/emergency = 20,
				/obj/item/storage/toolbox/repairs = 20,
				/obj/item/storage/toolbox/syndicate = 1)

/obj/random/tech_supply
	name = "random tech supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50

/obj/random/tech_supply/spawn_choices()
	return list(/obj/random/powercell = 3,
				/obj/random/technology_scanner = 2,
				/obj/item/stack/package_wrap/twenty_five = 1,
				/obj/item/hand_labeler = 1,
				/obj/random/bomb_supply = 2,
				/obj/item/extinguisher = 1,
				/obj/item/clothing/gloves/insulated/cheap = 1,
				/obj/item/stack/cable_coil/random = 2,
				/obj/random/toolbox = 2,
				/obj/item/storage/belt/utility = 2,
				/obj/item/storage/belt/utility/atmostech = 1,
				/obj/random/tool = 5,
				/obj/item/tape_roll = 2)

/obj/random/medical
	name = "Random Medical equipment"
	desc = "This is a random medical item."
	icon = 'icons/obj/items/random_spawn.dmi'
	icon_state = "medrandom"

/obj/random/medical/spawn_choices()
	return list(/obj/random/medical/lite = 21,
				/obj/item/bodybag = 2,
				/obj/item/chems/glass/bottle/stabilizer = 2,
				/obj/item/chems/glass/bottle/antitoxin = 2,
				/obj/item/storage/pill_bottle = 2,
				/obj/item/storage/pill_bottle/painkillers = 1,
				/obj/item/storage/pill_bottle/antidepressants = 2,
				/obj/item/storage/pill_bottle/oxygen = 1,
				/obj/item/storage/pill_bottle/burn_meds = 1,
				/obj/item/storage/pill_bottle/brute_meds = 1,
				/obj/item/chems/syringe/antitoxin = 2,
				/obj/item/chems/syringe/antibiotic = 1,
				/obj/item/chems/syringe/stabilizer = 2,
				/obj/item/storage/box/freezer = 1,
				/obj/item/stack/nanopaste = 1)

/obj/random/medical/lite
	name = "Random Medicine"
	desc = "This is a random simple medical item."
	icon = 'icons/obj/items/random_spawn.dmi'
	icon_state = "medrandom"
	spawn_nothing_percentage = 25

/obj/random/medical/lite/spawn_choices()
	return list(/obj/item/stack/medical/bruise_pack = 4,
				/obj/item/stack/medical/ointment = 4,
				/obj/item/storage/pill_bottle/antibiotics = 2,
				/obj/item/storage/pill_bottle/painkillers = 2,
				/obj/item/stack/medical/advanced/bruise_pack = 2,
				/obj/item/stack/medical/advanced/ointment = 2,
				/obj/item/stack/medical/splint = 1,
				/obj/item/chems/hypospray/autoinjector = 3,
				/obj/item/storage/pill_bottle/burn_meds = 2,
				/obj/item/storage/pill_bottle/antitox = 2,
				/obj/item/storage/med_pouch/trauma = 2,
				/obj/item/storage/med_pouch/burn = 2,
				/obj/item/storage/med_pouch/toxin = 2,
				/obj/item/storage/med_pouch/radiation = 2,
				/obj/item/storage/med_pouch/oxyloss = 2)

/obj/random/firstaid
	name = "Random First Aid Kit"
	desc = "This is a random first aid kit."
	icon = 'icons/obj/items/storage/firstaid.dmi'
	icon_state = "firstaid"

/obj/random/firstaid/spawn_choices()
	return list(/obj/item/storage/firstaid/regular = 4,
				/obj/item/storage/firstaid/trauma = 3,
				/obj/item/storage/firstaid/toxin = 3,
				/obj/item/storage/firstaid/o2 = 3,
				/obj/item/storage/firstaid/stab = 2,
				/obj/item/storage/firstaid/adv = 2,
				/obj/item/storage/firstaid/combat = 1,
				/obj/item/storage/firstaid/empty = 2,
				/obj/item/storage/firstaid/fire = 3)

/obj/random/contraband
	name = "Random Illegal Item"
	desc = "Hot Stuff."
	icon = 'icons/obj/items/comb.dmi'
	icon_state = "purplecomb"
	spawn_nothing_percentage = 50

/obj/random/contraband/spawn_choices()
	return list(/obj/item/haircomb = 4,
				/obj/item/storage/pill_bottle/painkillers = 3,
				/obj/item/storage/pill_bottle/happy = 2,
				/obj/item/storage/pill_bottle/zoom = 2,
				/obj/item/chems/glass/beaker/vial/random/toxin = 1,
				/obj/item/chems/glass/beaker/sulphuric = 1,
				/obj/item/contraband/poster = 5,
				/obj/item/butterflyblade = 3,
				/obj/item/butterflyhandle = 3,
				/obj/item/baton/cattleprod = 1,
				/obj/item/knife/combat = 1,
				/obj/item/knife/folding = 1,
				/obj/item/knife/folding/wood = 1,
				/obj/item/knife/folding/combat/balisong = 2,
				/obj/item/knife/folding/combat/switchblade = 1,
				/obj/item/storage/secure/briefcase/money = 1,
				/obj/item/storage/box/syndie_kit/cigarette = 1,
				/obj/item/stack/telecrystal = 1,
				/obj/item/clothing/under/syndicate = 2,
				/obj/item/chems/syringe = 3,
				/obj/item/chems/syringe/steroid = 2,
				/obj/item/chems/syringe/drugs = 1,
				/obj/item/chems/food/egg/lizard = 3)

/obj/random/drinkingglass
	name = "random drinking glass"
	desc = "This is a random drinking glass."
	icon = 'icons/obj/drink_glasses/square.dmi'
	icon_state = "square"

/obj/random/drinkingglass/spawn_choices()
	return list(
		/obj/item/chems/drinks/glass2/square,
		/obj/item/chems/drinks/glass2/rocks,
		/obj/item/chems/drinks/glass2/shake,
		/obj/item/chems/drinks/glass2/cocktail,
		/obj/item/chems/drinks/glass2/shot,
		/obj/item/chems/drinks/glass2/pint,
		/obj/item/chems/drinks/glass2/mug,
		/obj/item/chems/drinks/glass2/wine
	)

/obj/random/drinkbottle
	name = "random drink"
	desc = "This is a random drink."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "whiskeybottle"

/obj/random/drinkbottle/spawn_choices()
	return list(/obj/item/chems/drinks/bottle/whiskey,
				/obj/item/chems/drinks/bottle/gin,
				/obj/item/chems/drinks/bottle/agedwhiskey,
				/obj/item/chems/drinks/bottle/vodka,
				/obj/item/chems/drinks/bottle/tequila,
				/obj/item/chems/drinks/bottle/absinthe,
				/obj/item/chems/drinks/bottle/wine,
				/obj/item/chems/drinks/bottle/cognac,
				/obj/item/chems/drinks/bottle/rum,
				/obj/item/chems/drinks/bottle/patron)


/obj/random/energy
	name = "Random Energy Weapon"
	desc = "This is a random energy weapon."
	icon = 'icons/obj/guns/energy_gun.dmi'
	icon_state = "energykill100"

/obj/random/energy/spawn_choices()
	return list(/obj/item/gun/energy/laser = 4,
				/obj/item/gun/energy/gun = 3,
				/obj/item/gun/energy/lasercannon = 2,
				/obj/item/gun/energy/xray = 3,
				/obj/item/gun/energy/sniperrifle = 1,
				/obj/item/gun/energy/gun/nuclear = 1,
				/obj/item/gun/energy/ionrifle = 2,
				/obj/item/gun/energy/toxgun = 3,
				/obj/item/gun/energy/taser = 4,
				/obj/item/gun/energy/crossbow/largecrossbow = 2)

/obj/random/projectile
	name = "Random Projectile Weapon"
	desc = "This is a random projectile weapon."
	icon = 'icons/obj/guns/revolvers.dmi'
	icon_state = "revolver"

/obj/random/projectile/spawn_choices()
	return list(/obj/item/gun/projectile/shotgun/pump = 3,
				/obj/item/gun/projectile/automatic/assault_rifle = 2,
				/obj/item/gun/projectile/pistol = 3,
				/obj/item/gun/projectile/pistol/holdout = 4,
				/obj/item/gun/projectile/zipgun = 5,
				/obj/item/gun/projectile/automatic/smg = 4,
				/obj/item/gun/projectile/revolver = 2,
				/obj/item/gun/projectile/shotgun/doublebarrel = 4,
				/obj/item/gun/projectile/shotgun/doublebarrel/sawn = 3,
				/obj/item/gun/projectile/bolt_action/sniper = 1
				)

/obj/random/handgun
	name = "Random Handgun"
	desc = "This is a random sidearm."
	icon = 'icons/obj/guns/pistol.dmi'
	icon_state = "secguncomp"

/obj/random/handgun/spawn_choices()
	return list(/obj/item/gun/projectile/pistol = 3,
				/obj/item/gun/energy/gun = 3,
				/obj/item/gun/projectile/pistol/holdout = 2
				)

/obj/random/ammo
	name = "Random Ammunition"
	desc = "This is random ammunition."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "magnum"

/obj/random/ammo/spawn_choices()
	return list(/obj/item/storage/box/ammo/beanbags = 6,
				/obj/item/storage/box/ammo/shotgunammo = 2,
				/obj/item/storage/box/ammo/shotgunshells = 4,
				/obj/item/storage/box/ammo/stunshells = 1,
				/obj/item/ammo_magazine/pistol = 2,
				/obj/item/ammo_magazine/smg = 2,
				/obj/item/ammo_magazine/smg/rubber = 6
				)

/obj/random/action_figure
	name = "random action figure"
	desc = "This is a random action figure."
	icon = 'icons/obj/toy.dmi'
	icon_state = "assistant"

/obj/random/action_figure/spawn_choices()
	return list(/obj/item/toy/figure/cmo,
				/obj/item/toy/figure/assistant,
				/obj/item/toy/figure/atmos,
				/obj/item/toy/figure/bartender,
				/obj/item/toy/figure/borg,
				/obj/item/toy/figure/gardener,
				/obj/item/toy/figure/captain,
				/obj/item/toy/figure/cargotech,
				/obj/item/toy/figure/ce,
				/obj/item/toy/figure/chaplain,
				/obj/item/toy/figure/chef,
				/obj/item/toy/figure/chemist,
				/obj/item/toy/figure/clown,
				/obj/item/toy/figure/corgi,
				/obj/item/toy/figure/detective,
				/obj/item/toy/figure/dsquad,
				/obj/item/toy/figure/engineer,
				/obj/item/toy/figure/geneticist,
				/obj/item/toy/figure/hop,
				/obj/item/toy/figure/hos,
				/obj/item/toy/figure/qm,
				/obj/item/toy/figure/janitor,
				/obj/item/toy/figure/agent,
				/obj/item/toy/figure/librarian,
				/obj/item/toy/figure/md,
				/obj/item/toy/figure/mime,
				/obj/item/toy/figure/miner,
				/obj/item/toy/figure/ninja,
				/obj/item/toy/figure/wizard,
				/obj/item/toy/figure/rd,
				/obj/item/toy/figure/roboticist,
				/obj/item/toy/figure/scientist,
				/obj/item/toy/figure/syndie,
				/obj/item/toy/figure/secofficer,
				/obj/item/toy/figure/warden,
				/obj/item/toy/figure/psychologist,
				/obj/item/toy/figure/paramedic,
				/obj/item/toy/figure/ert)


/obj/random/plushie
	name = "random plushie"
	desc = "This is a random plushie."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nymphplushie"

/obj/random/plushie/spawn_choices()
	return list(/obj/item/toy/plushie/mouse,
				/obj/item/toy/plushie/kitten,
				/obj/item/toy/plushie/lizard)

/obj/random/plushie/large
	name = "random large plushie"
	desc = "This is a random large plushie."
	icon = 'icons/obj/toy.dmi'
	icon_state = "droneplushie"

/obj/random/plushie/large/spawn_choices()
	return list(/obj/structure/plushie/ian,
				/obj/structure/plushie/drone,
				/obj/structure/plushie/carp,
				/obj/structure/plushie/beepsky)

/obj/random/junk //Broken items, or stuff that could be picked up
	name = "random junk"
	desc = "This is some random junk."
	icon = 'icons/obj/items/storage/trashbag.dmi'
	icon_state = "trashbag3"

/obj/random/junk/spawn_choices()
	return list(get_random_junk_type())

/obj/random/trash //Mostly remains and cleanable decals. Stuff a janitor could clean up
	name = "random trash"
	desc = "This is some random trash."
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenglow"

/obj/random/trash/spawn_choices()
	return list(/obj/item/remains/lizard,
				/obj/effect/decal/cleanable/blood/gibs/robot,
				/obj/effect/decal/cleanable/blood/oil,
				/obj/effect/decal/cleanable/blood/oil/streak,
				/obj/effect/decal/cleanable/spiderling_remains,
				/obj/item/remains/mouse,
				/obj/effect/decal/cleanable/vomit,
				/obj/effect/decal/cleanable/blood/splatter,
				/obj/effect/decal/cleanable/ash,
				/obj/effect/decal/cleanable/generic,
				/obj/effect/decal/cleanable/flour,
				/obj/effect/decal/cleanable/dirt,
				/obj/item/remains/robot)


/obj/random/closet //A couple of random closets to spice up maint
	name = "random closet"
	desc = "This is a random closet."
	icon = 'icons/obj/closets/bases/closet.dmi'
	icon_state = "base"
	var/vermin_chance = 0.1
	var/list/locker_vermin = list(
		/mob/living/simple_animal/mouse,
		/mob/living/simple_animal/opossum
	)

/obj/random/closet/spawn_choices()
	return list(/obj/structure/closet,
				/obj/structure/closet/firecloset,
				/obj/structure/closet/emcloset,
				/obj/structure/closet/jcloset,
				/obj/structure/closet/athletic_mixed,
				/obj/structure/closet/toolcloset,
				/obj/structure/closet/l3closet/general,
				/obj/structure/closet/cabinet,
				/obj/structure/closet/crate,
				/obj/structure/closet/crate/freezer,
				/obj/structure/closet/crate/freezer/rations,
				/obj/structure/closet/crate/internals,
				/obj/structure/closet/crate/trashcart,
				/obj/structure/closet/crate/medical,
				/obj/structure/closet/boxinggloves,
				/obj/structure/largecrate,
				/obj/structure/closet/wardrobe/xenos,
				/obj/structure/closet/wardrobe/mixed,
				/obj/structure/closet/wardrobe/suit,
				/obj/structure/closet/wardrobe/orange
				)
/obj/random/closet/spawn_item()
	. = ..()
	if(. && length(locker_vermin) && prob(vermin_chance))
		var/vermin_type = pickweight(locker_vermin)
		new vermin_type(.)

/obj/random/coin
	name = "random coin"
	desc = "This is a random coin."
	icon = 'icons/obj/items/coin.dmi'
	icon_state = "coin1"

/obj/random/coin/spawn_choices()
	return list(
		/obj/item/coin/gold = 3,
		/obj/item/coin/silver = 4,
		/obj/item/coin/diamond = 2,
		/obj/item/coin/iron = 4,
		/obj/item/coin/uranium = 3,
		/obj/item/coin/platinum = 1
	)

/obj/random/toy
	name = "random toy"
	desc = "This is a random toy."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ship"

/obj/random/toy/spawn_choices()
	return list(
		/obj/item/toy/bosunwhistle,
		/obj/item/toy/therapy_red,
		/obj/item/toy/therapy_purple,
		/obj/item/toy/therapy_blue,
		/obj/item/toy/therapy_yellow,
		/obj/item/toy/therapy_orange,
		/obj/item/toy/therapy_green,
		/obj/item/sword/cult_toy,
		/obj/item/sword/katana/toy,
		/obj/item/toy/snappop,
		/obj/item/toy/sword,
		/obj/item/toy/water_balloon,
		/obj/item/gun/launcher/foam/crossbow,
		/obj/item/toy/blink,
		/obj/item/toy/prize/powerloader,
		/obj/item/toy/prize/fireripley,
		/obj/item/toy/prize/deathripley,
		/obj/item/toy/prize/gygax,
		/obj/item/toy/prize/durand,
		/obj/item/toy/prize/honk,
		/obj/item/toy/prize/marauder,
		/obj/item/toy/prize/seraph,
		/obj/item/toy/prize/mauler,
		/obj/item/toy/prize/odysseus,
		/obj/item/toy/prize/phazon,
		/obj/item/toy/spinningtoy,
		/obj/item/deck/cards
	)

/obj/random/tank
	name = "random tank"
	desc = "This is a tank."
	icon = 'icons/obj/items/tanks/tank_blue.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/tank/spawn_choices()
	return list(/obj/item/tank/oxygen = 5,
				/obj/item/tank/oxygen/yellow = 4,
				/obj/item/tank/emergency/oxygen/double/red = 4,
				/obj/item/tank/air = 3,
				/obj/item/tank/emergency/oxygen = 4,
				/obj/item/tank/emergency/oxygen/engi = 3,
				/obj/item/tank/emergency/oxygen/double = 2,
				/obj/item/tank/nitrogen = 1,
				/obj/item/suit_cooling_unit = 1)

/obj/random/material //Random materials for building stuff
	name = "random material"
	desc = "This is a random material."
	icon = 'icons/obj/materials.dmi'
	icon_state = "sheet"

/obj/random/material/spawn_choices()
	return list(
		/obj/item/stack/material/sheet/mapped/steel/ten,
		/obj/item/stack/material/pane/mapped/glass/ten,
		/obj/item/stack/material/pane/mapped/rglass/ten,
		/obj/item/stack/material/panel/mapped/plastic/ten,
		/obj/item/stack/material/plank/mapped/wood/ten,
		/obj/item/stack/material/cardstock/mapped/cardboard/ten,
		/obj/item/stack/material/reinforced/mapped/plasteel/ten,
		/obj/item/stack/material/sheet/mapped/steel/fifty,
		/obj/item/stack/material/reinforced/mapped/fiberglass/fifty,
		/obj/item/stack/material/ingot/mapped/copper/fifty,
		/obj/item/stack/material/pane/mapped/glass/fifty,
		/obj/item/stack/material/pane/mapped/rglass/fifty,
		/obj/item/stack/material/panel/mapped/plastic/fifty,
		/obj/item/stack/material/plank/mapped/wood/fifty,
		/obj/item/stack/material/cardstock/mapped/cardboard/fifty,
		/obj/item/stack/material/reinforced/mapped/plasteel/fifty,
		/obj/item/stack/material/rods/ten,
		/obj/item/stack/material/rods/fifty
	)

/obj/random/soap
	name = "Random Cleaning Supplies"
	desc = "This is a random bar of soap. Soap! SOAP?! SOAP!!!"
	icon = 'icons/obj/items/random_spawn.dmi'
	icon_state = "soaprandom"

/obj/random/soap/spawn_choices()
	return list(/obj/item/soap = 12,
				/obj/item/chems/glass/rag = 2,
				/obj/item/chems/spray/cleaner = 2,
				/obj/item/grenade/chem_grenade/cleaner = 1)

/obj/random/obstruction //Large objects to block things off in maintenance
	name = "random obstruction"
	desc = "This is a random obstruction."
	icon = 'icons/obj/cult.dmi'
	icon_state = "cultgirder"

/obj/random/obstruction/spawn_choices()
	return list(/obj/structure/barricade,
				/obj/structure/girder,
				/obj/structure/girder/displaced,
				/obj/structure/grille,
				/obj/structure/grille/broken,
				/obj/structure/foamedmetal,
				/obj/item/caution,
				/obj/item/caution/cone,
				/obj/structure/inflatable/wall,
				/obj/structure/inflatable/door)

/obj/random/assembly
	name = "random assembly"
	desc = "This is a random circuit assembly."
	icon = 'icons/obj/items/gift_wrapped.dmi'
	icon_state = "gift1"

/obj/random/assembly/spawn_choices()
	return list(/obj/item/electronic_assembly,
				/obj/item/electronic_assembly/medium,
				/obj/item/electronic_assembly/large,
				/obj/item/electronic_assembly/drone)

/obj/random/advdevice
	name = "random advanced device"
	desc = "This is a random advanced device."
	icon = 'icons/obj/items/gamekit.dmi'
	icon_state = "game_kit"

/obj/random/advdevice/spawn_choices()
	return list(/obj/item/flashlight/lantern,
				/obj/item/flashlight/flare,
				/obj/item/flashlight/pen,
				/obj/item/toner,
				/obj/item/paicard,
				/obj/item/destTagger,
				/obj/item/beartrap,
				/obj/item/handcuffs,
				/obj/item/camera,
				/obj/item/modular_computer/pda,
				/obj/item/card/emag_broken,
				/obj/item/radio/headset,
				/obj/item/flashlight/flare/glowstick/yellow,
				/obj/item/flashlight/flare/glowstick/orange,
				/obj/item/grenade/light,
				/obj/item/oxycandle)

/obj/random/smokes
	name = "random smokeable"
	desc = "This is a random smokeable item."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "Bpacket"

/obj/random/smokes/spawn_choices()
	return list(/obj/item/storage/fancy/cigarettes = 5,
				/obj/item/storage/fancy/cigarettes/dromedaryco = 4,
				/obj/item/storage/fancy/cigarettes/killthroat = 1,
				/obj/item/storage/fancy/cigarettes/luckystars = 3,
				/obj/item/storage/fancy/cigarettes/jerichos = 3,
				/obj/item/storage/fancy/cigarettes/menthols = 2,
				/obj/item/storage/fancy/cigarettes/carcinomas = 3,
				/obj/item/storage/fancy/cigarettes/professionals = 2,
				/obj/item/storage/fancy/cigar = 1,
				/obj/item/clothing/mask/smokable/cigarette = 2,
				/obj/item/clothing/mask/smokable/cigarette/menthol = 2,
				/obj/item/clothing/mask/smokable/cigarette/cigar = 1,
				/obj/item/clothing/mask/smokable/cigarette/cigar/cohiba = 1,
				/obj/item/clothing/mask/smokable/cigarette/cigar/havana = 1)

/obj/random/masks
	name = "random mask"
	desc = "This is a random face mask."
	icon = 'icons/clothing/mask/gas_mask.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/masks/spawn_choices()
	return list(/obj/item/clothing/mask/gas = 4,
				/obj/item/clothing/mask/gas/half = 5,
				/obj/item/clothing/mask/gas/swat = 1,
				/obj/item/clothing/mask/gas/syndicate = 1,
				/obj/item/clothing/mask/breath = 6,
				/obj/item/clothing/mask/breath/medical = 4,
				/obj/item/clothing/mask/balaclava = 3,
				/obj/item/clothing/mask/balaclava/tactical = 2,
				/obj/item/clothing/mask/surgical = 4)

/obj/random/snack
	name = "random snack"
	desc = "This is a random snack item."
	icon = 'icons/obj/food.dmi'
	icon_state = "sosjerky"

/obj/random/snack/spawn_choices()
	return list(/obj/item/chems/food/liquidfood,
				/obj/item/chems/food/candy,
				/obj/item/chems/drinks/dry_ramen,
				/obj/item/chems/food/chips,
				/obj/item/chems/food/sosjerky,
				/obj/item/chems/food/no_raisin,
				/obj/item/chems/food/spacetwinkie,
				/obj/item/chems/food/cheesiehonkers,
				/obj/item/chems/food/tastybread,
				/obj/item/chems/food/candy/proteinbar,
				/obj/item/chems/food/syndicake,
				/obj/item/chems/food/donut,
				/obj/item/chems/food/donut/cherryjelly,
				/obj/item/chems/food/donut/jelly,
				/obj/item/pizzabox/meat,
				/obj/item/pizzabox/vegetable,
				/obj/item/pizzabox/margherita,
				/obj/item/pizzabox/mushroom,
				/obj/item/chems/food/plumphelmetbiscuit)


/obj/random/storage
	name = "random storage item"
	desc = "This is a storage item."
	icon = 'icons/obj/items/storage/box.dmi'
	icon_state = "idOld"

/obj/random/storage/spawn_choices()
	return list(/obj/item/storage/secure/briefcase = 2,
				/obj/item/storage/briefcase = 4,
				/obj/item/storage/briefcase/inflatable = 3,
				/obj/item/storage/backpack = 5,
				/obj/item/storage/backpack/satchel = 5,
				/obj/item/storage/backpack/dufflebag = 2,
				/obj/item/storage/box = 5,
				/obj/item/storage/box/donkpockets = 3,
				/obj/item/storage/box/sinpockets = 1,
				/obj/item/storage/box/donut = 2,
				/obj/item/storage/box/cups = 3,
				/obj/item/storage/box/mousetraps = 4,
				/obj/item/storage/box/engineer = 3,
				/obj/item/storage/box/autoinjectors = 2,
				/obj/item/storage/box/beakers = 3,
				/obj/item/storage/box/syringes = 3,
				/obj/item/storage/box/gloves = 3,
				/obj/item/storage/box/large = 2,
				/obj/item/storage/box/glowsticks = 3,
				/obj/item/storage/wallet = 1,
				/obj/item/storage/ore = 2,
				/obj/item/storage/belt/utility/full = 2,
				/obj/item/storage/belt/medical/emt = 2,
				/obj/item/storage/belt/medical = 2,
				/obj/item/storage/belt/holster/security = 2,
				/obj/item/storage/belt/holster/security/tactical = 1)

/obj/random/shoes
	name = "random footwear"
	desc = "This is a random pair of shoes."
	icon = 'icons/clothing/feet/generic_shoes.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/shoes/spawn_choices()
	return list(/obj/item/clothing/shoes/workboots = 3,
				/obj/item/clothing/shoes/jackboots = 3,
				/obj/item/clothing/shoes/jackboots/swat = 1,
				/obj/item/clothing/shoes/jackboots/swat/combat = 1,
				/obj/item/clothing/shoes/galoshes = 2,
				/obj/item/clothing/shoes/syndigaloshes = 1,
				/obj/item/clothing/shoes/magboots = 1,
				/obj/item/clothing/shoes/dress = 4,
				/obj/item/clothing/shoes/jackboots/jungleboots = 3,
				/obj/item/clothing/shoes/jackboots/desertboots = 3,
				/obj/item/clothing/shoes/jackboots/duty = 3,
				/obj/item/clothing/shoes/jackboots/tactical = 1,
				/obj/item/clothing/shoes/color/black = 4,
				/obj/item/clothing/shoes/dress = 3,
				/obj/item/clothing/shoes/dress/white = 3,
				/obj/item/clothing/shoes/sandal = 3,
				/obj/item/clothing/shoes/color/brown = 4,
				/obj/item/clothing/shoes/color/red = 4,
				/obj/item/clothing/shoes/color/blue = 4,
				/obj/item/clothing/shoes/craftable = 4)

/obj/random/gloves
	name = "random gloves"
	desc = "This is a random pair of gloves."
	icon = 'icons/clothing/hands/gloves_generic.dmi'
	icon_state = ICON_STATE_INV

/obj/random/gloves/spawn_choices()
	return list(/obj/item/clothing/gloves/insulated = 3,
				/obj/item/clothing/gloves/thick = 6,
				/obj/item/clothing/gloves/thick/botany = 5,
				/obj/item/clothing/gloves/latex = 4,
				/obj/item/clothing/gloves/thick/swat = 3,
				/obj/item/clothing/gloves/thick/combat = 3,
				/obj/item/clothing/gloves/color/white = 5,
				/obj/item/clothing/gloves/rainbow = 1,
				/obj/item/clothing/gloves/thick/duty = 5,
				/obj/item/clothing/gloves/guards = 3,
				/obj/item/clothing/gloves/tactical = 3,
				/obj/item/clothing/gloves/insulated/cheap = 5)

/obj/random/glasses
	name = "random eyewear"
	desc = "This is a random pair of glasses."
	icon = 'icons/clothing/eyes/glasses_prescription.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/glasses/spawn_choices()
	return list(/obj/item/clothing/glasses/sunglasses = 3,
				/obj/item/clothing/glasses/prescription = 7,
				/obj/item/clothing/glasses/meson = 5,
				/obj/item/clothing/glasses/meson/prescription = 4,
				/obj/item/clothing/glasses/science = 6,
				/obj/item/clothing/glasses/material = 5,
				/obj/item/clothing/glasses/welding = 3,
				/obj/item/clothing/glasses/hud/health = 4,
				/obj/item/clothing/glasses/hud/health/prescription = 3,
				/obj/item/clothing/glasses/hud/security = 4,
				/obj/item/clothing/glasses/hud/security/prescription = 3,
				/obj/item/clothing/glasses/sunglasses/sechud = 2,
				/obj/item/clothing/glasses/sunglasses/sechud/toggle = 3,
				/obj/item/clothing/glasses/sunglasses/sechud/goggles = 1,
				/obj/item/clothing/glasses/tacgoggles = 1)

/obj/random/hat
	name = "random headgear"
	desc = "This is a random hat of some kind."
	icon = 'icons/clothing/head/softcap.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/hat/spawn_choices()
	return list(/obj/item/clothing/head/helmet = 2,
				/obj/item/clothing/head/helmet/tactical = 1,
				/obj/item/clothing/head/helmet/space/emergency = 1,
				/obj/item/clothing/head/bio_hood/general = 1,
				/obj/item/clothing/head/hardhat = 4,
				/obj/item/clothing/head/hardhat/orange = 4,
				/obj/item/clothing/head/hardhat/red = 4,
				/obj/item/clothing/head/hardhat/dblue = 4,
				/obj/item/clothing/head/ushanka = 3,
				/obj/item/clothing/head/welding = 2)

/obj/random/suit
	name = "random suit"
	desc = "This is a random piece of outerwear."
	icon = 'icons/clothing/suit/firesuit.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/suit/spawn_choices()
	return list(/obj/item/clothing/suit/storage/hazardvest = 4,
				/obj/item/clothing/suit/storage/toggle/labcoat = 4,
				/obj/item/clothing/suit/space/emergency = 1,
				/obj/item/clothing/suit/armor/vest = 4,
				/obj/item/clothing/suit/armor/pcarrier/tactical = 1,
				/obj/item/clothing/suit/armor/vest/heavy = 3,
				/obj/item/clothing/suit/storage/toggle/bomber = 3,
				/obj/item/clothing/suit/chef/classic = 3,
				/obj/item/clothing/suit/surgicalapron = 2,
				/obj/item/clothing/suit/apron/overalls = 3,
				/obj/item/clothing/suit/bio_suit/general = 1,
				/obj/item/clothing/suit/storage/toggle/hoodie/black = 3,
				/obj/item/clothing/suit/storage/toggle/brown_jacket = 3,
				/obj/item/clothing/suit/storage/leather_jacket = 3,
				/obj/item/clothing/suit/apron = 4)

/obj/random/clothing
	name = "random clothes"
	desc = "This is a random piece of clothing."
	icon = 'icons/clothing/under/jumpsuits/jumpsuit.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/clothing/spawn_choices()
	return list(/obj/item/clothing/under/syndicate/tacticool = 2,
				/obj/item/clothing/under/syndicate/combat = 1,
				/obj/item/clothing/under/hazard = 4,
				/obj/item/clothing/under/sterile = 4,
				/obj/item/clothing/pants/casual/camo = 2,
				/obj/item/clothing/under/frontier = 2,
				/obj/item/clothing/under/harness = 2,
				/obj/item/clothing/under/medical/paramedic = 2,
				/obj/item/clothing/under/overalls = 2,
				/obj/item/clothing/head/earmuffs = 2,
				/obj/item/clothing/under/tactical = 1)

/obj/random/accessory
	name = "random accessory"
	desc = "This is a random utility accessory."
	icon = 'icons/clothing/accessories/ties/tie_horrible.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/accessory/spawn_choices()
	return list(/obj/item/clothing/accessory/storage = 3,
				/obj/item/clothing/accessory/storage/webbing_large = 3,
				/obj/item/clothing/accessory/storage/vest/black = 2,
				/obj/item/clothing/accessory/storage/vest/brown = 2,
				/obj/item/clothing/accessory/storage/vest = 2,
				/obj/item/clothing/accessory/storage/bandolier = 1,
				/obj/item/clothing/accessory/storage/holster/thigh = 1,
				/obj/item/clothing/accessory/storage/holster/hip = 1,
				/obj/item/clothing/accessory/storage/holster/waist = 1,
				/obj/item/clothing/accessory/storage/holster/armpit = 1,
				/obj/item/clothing/accessory/kneepads = 3,
				/obj/item/clothing/accessory/stethoscope = 2)

/obj/random/cash
	name = "random currency"
	desc = "LOADSAMONEY!"
	icon = 'icons/obj/items/money.dmi'
	icon_state = "cash"

/obj/random/cash/spawn_choices()
	return list(/obj/item/cash/c1 = 4,
				/obj/item/cash/c10 = 3,
				/obj/item/cash/c20 = 3,
				/obj/item/cash/c50 = 2,
				/obj/item/cash/c100 = 2,
				/obj/item/cash/c1000 = 1)

/obj/random/documents // top secret documents, mostly overriden by maps
	name = "random secret documents"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "docs_generic"

/obj/random/documents/spawn_choices()
	return list(/obj/item/documents)

/obj/random/maintenance //Clutter and loot for maintenance and away missions
	name = "random maintenance item"
	desc = "This is a random maintenance item."
	icon = 'icons/obj/items/gift_wrapped.dmi'
	icon_state = "gift1"

/obj/random/maintenance/spawn_choices()
	return list(/obj/random/junk = 4,
				/obj/random/trash = 4,
				/obj/random/maintenance/clean = 5)

/obj/random/maintenance/clean
/*Maintenance loot lists without the trash, for use inside things.
Individual items to add to the maintenance list should go here, if you add
something, make sure it's not in one of the other lists.*/
	name = "random clean maintenance item"
	desc = "This is a random clean maintenance item."
	icon = 'icons/obj/items/gift_wrapped.dmi'
	icon_state = "gift2"

/obj/random/maintenance/clean/spawn_choices()
	return list(/obj/random/tech_supply = 100,
				/obj/random/medical = 40,
				/obj/random/medical/lite = 80,
				/obj/random/firstaid = 20,
				/obj/random/powercell = 50,
				/obj/random/technology_scanner = 80,
				/obj/random/bomb_supply = 80,
				/obj/random/contraband = 1,
				/obj/random/action_figure = 2,
				/obj/random/plushie = 2,
				/obj/random/material = 40,
				/obj/random/coin = 5,
				/obj/random/toy = 20,
				/obj/random/tank = 20,
				/obj/random/soap = 5,
				/obj/random/drinkbottle = 5,
				/obj/random/loot = 1,
				/obj/random/advdevice = 50,
				/obj/random/smokes = 30,
				/obj/random/masks = 10,
				/obj/random/snack = 60,
				/obj/random/storage = 30,
				/obj/random/shoes = 20,
				/obj/random/gloves = 10,
				/obj/random/glasses = 20,
				/obj/random/hat = 10,
				/obj/random/suit = 20,
				/obj/random/clothing = 30,
				/obj/random/accessory = 20,
				/obj/random/cash = 10)

/obj/random/loot /*Better loot for away missions and salvage */
	name = "random loot"
	desc = "This is some random loot."
	icon = 'icons/obj/items/gift_wrapped.dmi'
	icon_state = "gift3"

/obj/random/loot/spawn_choices()
	return list(/obj/random/energy = 10,
				/obj/random/projectile = 10,
				/obj/random/voidhelmet = 10,
				/obj/random/voidsuit = 10,
				/obj/random/hardsuit = 10,
				/obj/item/clothing/mask/muzzle = 7,
				/obj/item/clothing/mask/gas/syndicate = 10,
				/obj/item/clothing/glasses/night = 3,
				/obj/item/clothing/glasses/thermal = 1,
				/obj/item/clothing/glasses/welding/superior = 7,
				/obj/item/clothing/head/collectable/petehat = 4,
				/obj/item/clothing/suit/armor/pcarrier/merc = 3,
				/obj/item/clothing/suit/straight_jacket = 6,
				/obj/item/clothing/head/helmet/merc = 3,
				/obj/item/stack/material/gemstone/mapped/diamond/ten = 7,
				/obj/item/stack/material/pane/mapped/rborosilicate/ten = 7,
				/obj/item/stack/material/brick/mapped/marble/ten = 8,
				/obj/item/stack/material/ingot/mapped/gold/ten = 7,
				/obj/item/stack/material/ingot/mapped/silver/ten = 7,
				/obj/item/stack/material/ingot/mapped/osmium/ten = 7,
				/obj/item/stack/material/ingot/mapped/platinum/ten = 8,
				/obj/item/stack/material/aerogel/mapped/tritium/ten = 7,
				/obj/item/stack/material/segment/mapped/mhydrogen/ten = 6,
				/obj/item/stack/material/reinforced/mapped/plasteel/ten = 9,
				/obj/item/stack/material/ingot/mapped/copper/ten = 8,
				/obj/item/storage/box/monkeycubes = 5,
				/obj/item/storage/firstaid/surgery = 4,
				/obj/item/cell/infinite = 1,
				/obj/item/archaeological_find = 2,
				/obj/structure/artifact = 1,
				/obj/item/multitool/hacktool = 2,
				/obj/item/surgicaldrill = 7,
				/obj/item/sutures = 7,
				/obj/item/retractor = 7,
				/obj/item/hemostat = 7,
				/obj/item/cautery = 7,
				/obj/item/bonesetter = 7,
				/obj/item/bonegel = 7,
				/obj/item/circular_saw = 7,
				/obj/item/scalpel = 7,
				/obj/item/baton/loaded = 9,
				/obj/item/radio/headset/syndicate = 6)

/obj/random/voidhelmet
	name = "Random Voidsuit Helmet"
	desc = "This is a random voidsuit helmet."
	icon = 'icons/clothing/spacesuit/generic/helmet.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/voidhelmet/spawn_choices()
	return list(/obj/item/clothing/head/helmet/space/void,
				/obj/item/clothing/head/helmet/space/void/engineering,
				/obj/item/clothing/head/helmet/space/void/engineering/alt,
				/obj/item/clothing/head/helmet/space/void/engineering/salvage,
				/obj/item/clothing/head/helmet/space/void/mining,
				/obj/item/clothing/head/helmet/space/void/mining/alt,
				/obj/item/clothing/head/helmet/space/void/security,
				/obj/item/clothing/head/helmet/space/void/security/alt,
				/obj/item/clothing/head/helmet/space/void/atmos,
				/obj/item/clothing/head/helmet/space/void/atmos/alt,
				/obj/item/clothing/head/helmet/space/void/merc,
				/obj/item/clothing/head/helmet/space/void/medical,
				/obj/item/clothing/head/helmet/space/void/medical/alt)

/obj/random/voidsuit
	name = "Random Voidsuit"
	desc = "This is a random voidsuit."
	icon = 'icons/clothing/spacesuit/void/nasa/suit.dmi'
	icon_state = ICON_STATE_WORLD

/obj/random/voidsuit/spawn_choices()
	return list(/obj/item/clothing/suit/space/void,
				/obj/item/clothing/suit/space/void/engineering,
				/obj/item/clothing/suit/space/void/engineering/alt,
				/obj/item/clothing/suit/space/void/engineering/salvage,
				/obj/item/clothing/suit/space/void/mining,
				/obj/item/clothing/suit/space/void/mining/alt,
				/obj/item/clothing/suit/space/void/security,
				/obj/item/clothing/suit/space/void/security/alt,
				/obj/item/clothing/suit/space/void/atmos,
				/obj/item/clothing/suit/space/void/atmos/alt,
				/obj/item/clothing/suit/space/void/merc,
				/obj/item/clothing/suit/space/void/medical,
				/obj/item/clothing/suit/space/void/medical/alt)

/obj/random/hardsuit
	name = "Random Hardsuit"
	desc = "This is a random hardsuit control module."
	icon = 'icons/obj/rig_modules.dmi'
	icon_state = "generic"

/obj/random/hardsuit/spawn_choices()
	return list(/obj/item/rig/industrial,
				/obj/item/rig/eva,
				/obj/item/rig/light/hacker,
				/obj/item/rig/light/stealth,
				/obj/item/rig/light)

/obj/random/hostile
	name = "Random Hostile Mob"
	desc = "This is a random hostile mob."
	icon = 'icons/mob/amorph.dmi'
	icon_state = "standing"
	spawn_nothing_percentage = 80

/obj/random/hostile/spawn_choices()
	return list(/mob/living/simple_animal/hostile/viscerator,
				/mob/living/simple_animal/hostile/carp,
				/mob/living/simple_animal/hostile/carp/pike,
				/mob/living/simple_animal/hostile/vagrant/swarm)

/*
	Selects one spawn point out of a group of points with the same ID and asks it to generate its items
*/
var/global/list/multi_point_spawns

/obj/random_multi
	name = "random object spawn point"
	desc = "This item type is used to spawn random objects at round-start. Only one spawn point for a given group id is selected."
	icon = 'icons/misc/mark.dmi'
	icon_state = "x3"
	invisibility = INVISIBILITY_MAXIMUM
	var/id     // Group id
	var/weight // Probability weight for this spawn point

/obj/random_multi/Initialize()
	. = ..()
	weight = max(1, round(weight))

	if(!multi_point_spawns)
		multi_point_spawns = list()
	var/list/spawnpoints = multi_point_spawns[id]
	if(!spawnpoints)
		spawnpoints = list()
		multi_point_spawns[id] = spawnpoints
	spawnpoints[src] = weight

/obj/random_multi/Destroy()
	var/list/spawnpoints = multi_point_spawns[id]
	spawnpoints -= src
	if(!spawnpoints.len)
		multi_point_spawns -= id
	. = ..()

/obj/random_multi/proc/generate_items()
	return

/obj/random_multi/single_item
	var/item_path  // Item type to spawn

/obj/random_multi/single_item/generate_items()
	new item_path(loc)

/hook/roundstart/proc/generate_multi_spawn_items()
	for(var/id in multi_point_spawns)
		var/list/spawn_points = multi_point_spawns[id]
		var/obj/random_multi/rm = pickweight(spawn_points)
		rm.generate_items()
		for(var/entry in spawn_points)
			qdel(entry)
	return 1

/obj/random_multi/single_item/captains_spare_id
	name = "Multi Point - Captain's Spare"
	id = "Captain's spare id"
	item_path = /obj/item/card/id/captains_spare

var/global/list/random_junk_
var/global/list/random_useful_
/proc/get_random_useful_type()
	if(!random_useful_)
		random_useful_ = list()
		random_useful_ += /obj/item/pen/crayon/random
		random_useful_ += /obj/item/pen
		random_useful_ += /obj/item/pen/blue
		random_useful_ += /obj/item/pen/red
		random_useful_ += /obj/item/pen/multi
		random_useful_ += /obj/item/storage/box/matches
		random_useful_ += /obj/item/stack/material/cardstock/mapped/cardboard
		random_useful_ += /obj/item/storage/fancy/cigarettes
		random_useful_ += /obj/item/deck/cards
	return pick(random_useful_)

/proc/get_random_junk_type()
	if(prob(20)) // Misc. clutter
		return /obj/effect/decal/cleanable/generic

	// 80% chance that we reach here
	if(prob(95)) // Misc. junk
		if(!random_junk_)
			random_junk_ = subtypesof(/obj/item/trash)
			random_junk_ += typesof(/obj/item/trash/cigbutt)
			random_junk_ += /obj/effect/decal/cleanable/spiderling_remains
			random_junk_ += /obj/item/remains/mouse
			random_junk_ += /obj/item/remains/robot
			random_junk_ += /obj/item/paper/crumpled
			random_junk_ += /obj/item/inflatable/torn
			random_junk_ += /obj/effect/decal/cleanable/molten_item
			random_junk_ += /obj/item/shard
			random_junk_ += /obj/item/hand/missing_card

			random_junk_ -= /obj/item/trash/plate
			random_junk_ -= /obj/item/trash/snack_bowl
			random_junk_ -= /obj/item/trash/syndi_cakes
			random_junk_ -= /obj/item/trash/tray
		return pick(random_junk_)

	// Misc. actually useful stuff or perhaps even food
	// 4% chance that we reach here
	if(prob(75))
		return get_random_useful_type()

	// 1% chance that we reach here
	var/lunches = lunchables_lunches()
	return lunches[pick(lunches)]

/obj/random/clipboard
	name = "random clipboard"
	desc = "This is a random material clipboard."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "clipboard_preview"

/obj/random/clipboard/spawn_choices()
	return list(/obj/item/clipboard = 300,
				/obj/item/clipboard/steel = 200,
				/obj/item/clipboard/aluminium = 200,
				/obj/item/clipboard/plastic = 200,
				/obj/item/clipboard/glass = 100,
				/obj/item/clipboard/ebony = 10)

//Random MRE stuff

/obj/random/mre
	name = "random MRE"
	desc = "This is a random single MRE."
	icon = 'icons/obj/food.dmi'
	icon_state = "mre"

/obj/random/mre/spawn_choices()
	return list(/obj/item/storage/mre,
				/obj/item/storage/mre/menu2,
				/obj/item/storage/mre/menu3,
				/obj/item/storage/mre/menu4,
				/obj/item/storage/mre/menu5,
				/obj/item/storage/mre/menu6,
				/obj/item/storage/mre/menu7,
				/obj/item/storage/mre/menu8,
				/obj/item/storage/mre/menu9,
				/obj/item/storage/mre/menu10)


/obj/random/mre/main
	name = "random MRE main course"
	desc = "This is a random main course for MREs."
	icon_state = "pouch_medium"

/obj/random/mre/main/spawn_choices()
	return list(/obj/item/storage/mrebag,
				/obj/item/storage/mrebag/menu2,
				/obj/item/storage/mrebag/menu3,
				/obj/item/storage/mrebag/menu4,
				/obj/item/storage/mrebag/menu5,
				/obj/item/storage/mrebag/menu6,
				/obj/item/storage/mrebag/menu7,
				/obj/item/storage/mrebag/menu8)

/obj/random/mre/dessert
	name = "random MRE dessert"
	desc = "This is a random dessert for MREs."
	icon_state = "pouch_medium"

/obj/random/mre/dessert/spawn_choices()
	return list(/obj/item/chems/food/candy,
				/obj/item/chems/food/candy/proteinbar,
				/obj/item/chems/food/donut/normal,
				/obj/item/chems/food/donut/cherryjelly,
				/obj/item/chems/food/chocolatebar,
				/obj/item/chems/food/cookie,
				/obj/item/chems/food/poppypretzel,
				/obj/item/clothing/mask/chewable/candy/gum)

/obj/random/mre/dessert/vegan
	name = "random vegan MRE dessert"
	desc = "This is a random vegan dessert for MREs."

/obj/random/mre/dessert/vegan/spawn_choices()
	return list(/obj/item/chems/food/candy,
				/obj/item/chems/food/chocolatebar,
				/obj/item/chems/food/donut/cherryjelly,
				/obj/item/chems/food/plumphelmetbiscuit)

/obj/random/mre/drink
	name = "random MRE drink"
	desc = "This is a random drink for MREs."
	icon_state = "packet_small"

/obj/random/mre/drink/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/coffee,
				/obj/item/chems/condiment/small/packet/tea,
				/obj/item/chems/condiment/small/packet/cocoa,
				/obj/item/chems/condiment/small/packet/grape,
				/obj/item/chems/condiment/small/packet/orange,
				/obj/item/chems/condiment/small/packet/watermelon,
				/obj/item/chems/condiment/small/packet/apple)

/obj/random/mre/spread
	name = "random MRE spread"
	desc = "This is a random spread packet for MREs."
	icon_state = "packet_small"

/obj/random/mre/spread/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/jelly,
				/obj/item/chems/condiment/small/packet/honey)

/obj/random/mre/spread/vegan
	name = "random vegan MRE spread"
	desc = "This is a random vegan spread packet for MREs"

/obj/random/mre/spread/vegan/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/jelly)

/obj/random/mre/sauce
	name = "random MRE sauce"
	desc = "This is a random sauce packet for MREs."
	icon_state = "packet_small"

/obj/random/mre/sauce/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/salt,
				/obj/item/chems/condiment/small/packet/pepper,
				/obj/item/chems/condiment/small/packet/sugar,
				/obj/item/chems/condiment/small/packet/capsaicin,
				/obj/item/chems/condiment/small/packet/ketchup,
				/obj/item/chems/condiment/small/packet/mayo,
				/obj/item/chems/condiment/small/packet/soy)

/obj/random/mre/sauce/vegan/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/salt,
				/obj/item/chems/condiment/small/packet/pepper,
				/obj/item/chems/condiment/small/packet/sugar,
				/obj/item/chems/condiment/small/packet/soy)

/obj/random/mre/sauce/sugarfree/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/salt,
				/obj/item/chems/condiment/small/packet/pepper,
				/obj/item/chems/condiment/small/packet/capsaicin,
				/obj/item/chems/condiment/small/packet/ketchup,
				/obj/item/chems/condiment/small/packet/mayo,
				/obj/item/chems/condiment/small/packet/soy)

/obj/random/mre/sauce/crayon/spawn_choices()
	return list(/obj/item/chems/condiment/small/packet/crayon,
				/obj/item/chems/condiment/small/packet/crayon/red,
				/obj/item/chems/condiment/small/packet/crayon/orange,
				/obj/item/chems/condiment/small/packet/crayon/yellow,
				/obj/item/chems/condiment/small/packet/crayon/green,
				/obj/item/chems/condiment/small/packet/crayon/blue,
				/obj/item/chems/condiment/small/packet/crayon/purple,
				/obj/item/chems/condiment/small/packet/crayon/grey,
				/obj/item/chems/condiment/small/packet/crayon/brown)

/obj/random/vendor
	name = "random vending machine"
	desc = "This is a randomly selected vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = ""

/obj/random/vendor/spawn_choices()
	return list(/obj/machinery/vending/weeb,
				/obj/machinery/vending/sol,
				/obj/machinery/vending/snix
				)

/obj/random/single/playing_cards
	name = "randomly spawned deck of cards"
	icon = 'icons/obj/items/playing_cards.dmi'
	icon_state = "deck"
	spawn_object = /obj/item/deck

/obj/random/single/lighter
	name = "randomly spawned lighter"
	icon = 'icons/obj/items/lighters.dmi'
	icon_state = "lighter"
	spawn_object = /obj/item/flame/lighter

/obj/random/single/cola
	name = "randomly spawned cola"
	icon = 'icons/obj/drinks.dmi'
	icon_state = "cola"
	spawn_object = /obj/item/chems/drinks/cans/cola

//textbooks
/obj/random/single/textbook
	name = "random textbook"
	icon = 'icons/obj/library.dmi'
	icon_state = "book"
	spawn_object = /obj/item/book/skill //Further randomization of which book is handled inside the book initialization
	spawn_nothing_percentage = 0

/obj/random/lipstick
	name = "random lipstick"
	desc = "This is a tube of lipstick."
	icon = 'icons/obj/items/lipstick.dmi'
	icon_state = "lipstick_closed"

/obj/random/lipstick/spawn_choices()
	return list(/obj/item/lipstick,
				/obj/item/lipstick/blue,
				/obj/item/lipstick/green,
				/obj/item/lipstick/turquoise,
				/obj/item/lipstick/violet,
				/obj/item/lipstick/yellow,
				/obj/item/lipstick/orange,
				/obj/item/lipstick/white,
				/obj/item/lipstick/black)

/obj/random/seaweed
	name = "random seaweed"
	desc = "This is some random seaweed."
	icon = 'icons/obj/structures/plants.dmi'
	icon_state = "seaweed"

/obj/random/seaweed/spawn_choices()
	return list(
		/obj/structure/flora/seaweed =       3,
		/obj/structure/flora/seaweed/mid =   3,
		/obj/structure/flora/seaweed/large = 2,
		/obj/structure/flora/seaweed/glow =  1
	)

/obj/random/pottedplant
	name = "random potted plant"
	desc = "This is a random potted plant."
	icon = 'icons/obj/structures/potted_plants.dmi'
	icon_state = "plant-26"	
	spawn_nothing_percentage = 0
	var/static/list/blacklisted_plants = list(/obj/structure/flora/pottedplant/unusual)

/obj/random/pottedplant/spawn_choices()
	return subtypesof(/obj/structure/flora/pottedplant) - blacklisted_plants

