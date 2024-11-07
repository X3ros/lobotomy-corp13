/mob/living/simple_animal/hostile/abnormality/chirurgeon
	name = "Caustic Chirurgeon"
	desc = "An oversized centipede wearing a porcelain mask. Its stomach is open, showing various medical tools."
	icon = 'ModularTegustation/Teguicons/64x64.dmi'
	icon_state = "chirurgeon"
	icon_living = "chirurgeon"
	pixel_x = -16
	//Portrait goes here//
	speak_emote = list("chitters")
	attack_verb_continuous = "attacks"
	attack_verb_simple = "attack"
	attack_sound = 'sound/abnormalities/censored/attack.ogg' //Placeholder sound until I actually bother looking for a more fitting one
	threat_level = HE_LEVEL
	maxHealth = 1200
	health = 1200
	faction = list("hostile", "surgery")
	damage_coeff = list(RED_DAMAGE = 0.7, WHITE_DAMAGE = 1.4, BLACK_DAMAGE = 0.6, PALE_DAMAGE = 2)
	melee_damage_type = RED_DAMAGE
	melee_damage_lower = 10
	melee_damage_upper = 17
	move_to_delay = 2.5

	//Works n shit//
	start_qliphoth = 3
	can_breach = TRUE
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = 30,
		ABNORMALITY_WORK_INSIGHT = 50,
		ABNORMALITY_WORK_ATTACHMENT = 10,
		ABNORMALITY_WORK_REPRESSION = 70,
	)
	work_damage_amount = 9
	work_damage_type = BLACK_DAMAGE

	ego_list = list(
		/datum/ego_datum/weapon/green_cross,
		/datum/ego_datum/armor/green_cross,
	)

	gift_type = /datum/ego_gifts/greencross
	abnormality_origin = ABNORMALITY_ORIGIN_ORIGINAL

/mob/living/simple_animal/hostile/abnormality/chirurgeon/FailureEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/surgical_error //Oh fuck what'd he do to Bob's body
	name = "Surgical Error"
	desc = "A malformed mess of body parts and organs in the vague shape of an animal. You think you recognize one of the heads..." //TODO: make the description update to reflect who was operated on
	icon = 'ModularTegustation/Teguicons/32x32.dmi'
	icon_state = "surgical_error"
	icon_living = "surgical_error"
	speak_emote = list("gurgles")
	attack_verb_continuous = "attacks"
	attack_verb_simple = "attack"
	attack_sound = 'sound/abnormalities/censored/mini_attack.ogg' //placeholder sound
	health = 250
	maxHealth = 250
	faction = list("neutral", "surgery")
	damage_coeff = list(RED_DAMAGE = 1, WHITE_DAMAGE = 1.2, BLACK_DAMAGE = 0.8, PALE_DAMAGE = 2)
	melee_damage_type = BLACK_DAMAGE
	melee_damage_lower = 8
	melee_damage_upper = 15
	del_on_death = TRUE //Temporary measure until I figure out how butchering drop pools work

/mob/living/simple_animal/hostile/surgical_error/Initialize()
	. = ..()
	playsound(get_turf(src), 'sound/abnormalities/censored/mini_born.ogg', 50, 1, 4)
	base_pixel_x = rand(-6,6)
	pixel_x = base_pixel_x
	base_pixel_y = rand(-6,6)
	pixel_y = base_pixel_y

/mob/living/simple_animal/hostile/abnormality/chirurgeon/CanAttack(atom/the_target) //Stop eating my fucking test subjects
	if(istype(the_target, /mob/living/simple_animal/hostile/abnormality/eris))
		var/mob/living/L = the_target
		if(L.stat != DEAD)
			return TRUE
	return ..()

	//BIG-ASS TO-DO LIST
	//1. Actually make it SPAWN the little dudes
	//2. Make it drag corpses back to its cell (probably difficult)
	//3. Add the qlip increase from spawning little guys while contained
	//4. Make it infight with/prioritize killing other corpse-eaters like MoSB and Eris
	//5. Make little dudes drop human meat when butchered
