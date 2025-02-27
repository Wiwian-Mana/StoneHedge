/datum/advclass/hedgeknight //heavy knight class - just like black knight adventurer class. starts with heavy armor training and plate, but less weapon skills than brigand, sellsword and knave
	name = "Rogue Knight"
	tutorial = "A noble fallen from grace, your tarnished armor sits upon your shoulders as a heavy reminder of the life you've lost. Take back what is rightfully yours."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	outfit = /datum/outfit/job/roguetown/bandit/hedgeknight
	category_tags = list(CTAG_DISABLED) //No confusion with real hedgeknights, maybe someone can rework this later.
	cmode_music = 'sound/music/combat_bandit2.ogg'
	maximum_possible_slots = 1
	min_pq = 30

/datum/outfit/job/roguetown/bandit/hedgeknight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/blkknight
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/bervor
	else
		neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather
	r_hand = /obj/item/rogueweapon/greatsword/zwei
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank_up_to(/datum/skill/craft/hunting, 1, TRUE)
	H.change_stat("strength", 4)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", -1)
	H.change_stat("speed", -2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC) //hey buddy you hear about roleplaying
	ADD_TRAIT(H, TRAIT_PERFECT_TRACKER, TRAIT_GENERIC)//forest police benefit so they can track their targets.
	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE
