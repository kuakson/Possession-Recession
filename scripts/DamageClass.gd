extends Resource

var damage_amount
var damage_type
var target

enum {SLASH, BLUNT, PIERCE, BLAST, BURN, PLASM}

func apply_damage(amount, type, target):
	if target.has_node("Health Component"):
		var HC = target.get_node("Health Component")
		match type:
			BLAST:
				if HC.blast_resistant: amount = 0
			PLASM:
				if not HC.incorporeal: amount = 0
			BURN:
				if HC.flammable: HC.on_fire = true

# to Health Componend - add on fire script AND  animation if damage is 0 (resistance)
