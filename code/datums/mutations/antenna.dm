/datum/mutation/human/antenna
	name = "Antenna"
	desc = ""
	quality = POSITIVE
	text_gain_indication = span_notice("I feel an antenna sprout from my forehead.")
	text_lose_indication = span_notice("My antenna shrinks back down.")
	instability = 5
	difficulty = 8
	var/obj/item/implant/radio/antenna/linked_radio

/obj/item/implant/radio/antenna
	name = "internal antenna organ"
	desc = ""
	icon = 'icons/obj/radio.dmi'//maybe make a unique sprite later. not important
	icon_state = "walkietalkie"

/obj/item/implant/radio/antenna/Initialize(mapload)
	. = ..()
	radio.name = "internal antenna"

/datum/mutation/human/antenna/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	linked_radio = new(owner)
	linked_radio.implant(owner, null, TRUE, TRUE)

/datum/mutation/human/antenna/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	if(linked_radio)
		QDEL_NULL(linked_radio)

/datum/mutation/human/antenna/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "antenna", -FRONT_MUTATIONS_LAYER+1))//-MUTATIONS_LAYER+1

/datum/mutation/human/antenna/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/human/mindreader
	name = "Mind Reader"
	desc = ""
	quality = POSITIVE
	text_gain_indication = span_notice("I hear distant voices at the corners of my mind.")
	text_lose_indication = span_notice("The distant voices fade.")
	power = /obj/effect/proc_holder/spell/targeted/mindread
	instability = 40
	difficulty = 8
	locked = TRUE

/obj/effect/proc_holder/spell/targeted/mindread
	name = "Mindread"
	desc = ""
	charge_max = 50
	range = 7
	clothes_req = FALSE
	action_icon_state = "mindread"

/obj/effect/proc_holder/spell/targeted/mindread/cast(list/targets, mob/living/carbon/human/user = usr)
	for(var/mob/living/M in targets)
		if(usr.anti_magic_check(FALSE, FALSE, TRUE, 0) || M.anti_magic_check(FALSE, FALSE, TRUE, 0))
			to_chat(usr, span_warning("As you reach out with my mind, you're suddenly stopped by a vision of a massive tinfoil wall that streches beyond visible range. It seems you've been foiled."))
			return
		if(M.stat == DEAD)
			to_chat(user, span_boldnotice("[M] is dead!"))
			return
		if(M.mind)
			to_chat(user, span_boldnotice("I plunge into [M]'s mind..."))
			if(prob(20))
				to_chat(M, span_danger("I feel something foreign enter my mind."))//chance to alert the read-ee
			var/list/recent_speech = list()
			var/list/say_log = list()
			var/log_source = M.logging
			for(var/log_type in log_source)//this whole loop puts the read-ee's say logs into say_log in an easy to access way
				var/nlog_type = text2num(log_type)
				if(nlog_type & LOG_SAY)
					var/list/reversed = log_source[log_type]
					if(islist(reversed))
						say_log = reverseRange(reversed.Copy())
						break
			if(LAZYLEN(say_log))
				for(var/spoken_memory in say_log)
					if(recent_speech.len >= 3)//up to 3 random lines of speech, favoring more recent speech
						break
					if(prob(50))
						recent_speech[spoken_memory] = say_log[spoken_memory]
			if(recent_speech.len)
				to_chat(user, span_boldnotice("I catch some drifting memories of their past conversations..."))
				for(var/spoken_memory in recent_speech)
					to_chat(user, span_notice("[recent_speech[spoken_memory]]"))
			if(iscarbon(M))
				var/mob/living/carbon/human/H = M
				to_chat(user, span_boldnotice("I find that their intent is to [H.used_intent]..."))
				var/datum/dna/the_dna = H.has_dna()
				if(the_dna)
					to_chat(user, span_boldnotice("I uncover that [H.p_their()] true identity is [the_dna.real_name]."))
		else
			to_chat(user, span_warning("I can't find a mind to read inside of [M]!"))

/datum/mutation/human/mindreader/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "antenna", -FRONT_MUTATIONS_LAYER+1))

/datum/mutation/human/mindreader/get_visual_indicator()
	return visual_indicators[type][1]
