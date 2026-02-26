# action_handler.gd
extends Node

func execute_action(action: CombatAction, caster: Character, opponent: Character) -> int:

	if action.type == Enums.CombatActionType.MAIN:
		match action.melee_subtype:
			Enums.CombatActionMelee.ATTACK:
				return _attack(action, caster, opponent)
			Enums.CombatActionMelee.HEAVY_ATTACK:
				return _heavy_attack(action, caster, opponent)
			Enums.CombatActionMelee.WAIT:
				return _wait(action, caster)
			Enums.CombatActionMelee.NONE:
				return 1
			_:
				return 3

	elif action.type == Enums.CombatActionType.SPELL:
		match action.spell_subtype:
			Enums.CombatActionSpells.HEAL:
				return _heal(action, caster)
			Enums.CombatActionSpells.FIREBALL:
				pass
			Enums.CombatActionSpells.LIGHTNING:
				return _lightning(action, caster, opponent)
			Enums.CombatActionSpells.NONE:
				return 1
			_:
				return 3

	elif action.type == Enums.CombatActionType.ABILITY:
		match action.ability_subtype:
			Enums.CombatActionAbilities.FOCUS_ENERGY:
				return _focus_energy(action, caster)
			Enums.CombatActionAbilities.GUARD:
				pass
			Enums.CombatActionAbilities.NONE:
				return 1
			_:
				return 3

	elif action.type == Enums.CombatActionType.ITEM:
		match action.item_subtype:
			Enums.CombatActionItems.HEALTH_POTION:
				return _health_potion(action, caster)
			Enums.CombatActionItems.STAMINA_POTION:
				return _stamina_potion(action, caster)
			Enums.CombatActionItems.MANA_POTION:
				return _mana_potion(action, caster)
			Enums.CombatActionItems.NONE:
				return 1
			_:
				return 3

	return 0

### --- MAIN/MELEE ACTIONS --- ###

func _attack(action: CombatAction, caster: Character, opponent: Character) -> int:
	if _check_stamina(action, caster):
		var damage: int = _calculate_damage(action, caster, opponent)
		caster.use_stamina(action.stamina_cost)
		opponent.take_damage(damage)
		return 0
	else:
		return 2

func _heavy_attack(action: CombatAction, caster: Character, opponent: Character) -> int:
	if _check_stamina(action, caster):
		var damage: int = _calculate_damage(action, caster, opponent)
		caster.use_stamina(action.stamina_cost)
		opponent.take_damage(damage)
		return 0
	else:
		return 2

func _wait(action: CombatAction, caster: Character) -> int:
	if _check_stamina(action, caster):
		caster.regain_stamina(-action.stamina_cost)
		caster.OnRest.emit(caster.stamina)
		return 0
	else:
		return 2

### --- SPELLS --- ###

func _heal(action: CombatAction, caster: Character) -> int:
	if _check_mana(action, caster) and _check_health(caster):
		caster.use_mana(action.mana_cost)
		caster.heal(action.heal_amount)
		caster.OnHeal.emit(caster.health)
		return 0
	else:
		return 2

func _lightning(action: CombatAction, caster: Character, opponent: Character) -> int:
	if _check_mana(action, caster):
		var damage: int = _calculate_damage(action, caster, opponent)
		caster.use_mana(action.mana_cost)
		opponent.take_damage(damage)
		opponent.OnLightning.emit()
		return 0
	else:
		return 2

### --- ABILITIES --- ###

func _focus_energy(action: CombatAction, caster: Character) -> int:
	if _check_mana(action, caster):
		caster.regain_mana(-action.mana_cost)
		caster.OnFocus.emit(caster.mana)
		return 0
	else:
		return 2

### --- ITEMS --- ###

func _health_potion(action: CombatAction, caster: Character) -> int:
	if _check_count(action, caster):
		if _check_health(caster):
			caster.heal(action.heal_amount)
			action.item_count -= 1
			caster.OnHealthPotion.emit(caster.health)
			return 0
		else:
			return 2
	else:
		print("No health potions left!")
		caster.OnNoneLeft.emit(Enums.CombatActionItems.HEALTH_POTION)
		return 2

func _stamina_potion(action: CombatAction, caster: Character) -> int:
	if _check_count(action, caster):
		if _check_stamina(action, caster):
			caster.regain_stamina(-action.stamina_cost)
			action.item_count -= 1
			caster.OnStaminaPotion.emit(caster.stamina)
			return 0
		else:
			return 2
	else:
		print("No stamina potions left!")
		caster.OnNoneLeft.emit(Enums.CombatActionItems.STAMINA_POTION)
		return 2

func _mana_potion(action: CombatAction, caster: Character) -> int:
	if _check_count(action, caster):
		if _check_mana(action, caster):
			caster.regain_mana(-action.mana_cost)
			action.item_count -= 1
			caster.OnManaPotion.emit(caster.mana)
			return 0
		else:
			return 2
	else:
		print("No mana potions left!")
		caster.OnNoneLeft.emit(Enums.CombatActionItems.MANA_POTION)
		return 2

### --- UTILITY --- ###

func _check_health(caster: Character) -> bool:
	if caster.health >= caster.max_health:
		print("Already at full health!")
		caster.OnAlreadyFull.emit(Enums.Attribute.HEALTH)
		return false

	return true

func _check_stamina(action:CombatAction, caster: Character) -> bool:
	if action.stamina_cost < 0 and caster.stamina >= caster.max_stamina:
		print("Already at full stamina!")
		caster.OnAlreadyFull.emit(Enums.Attribute.STAMINA)
		return false

	if action.stamina_cost > 0 and action.stamina_cost > caster.stamina:
		print("Not enough stamina!")
		caster.OnNotEnough.emit(Enums.Attribute.STAMINA)
		return false

	return true

func _check_mana(action:CombatAction, caster: Character) -> bool:
	if action.mana_cost < 0 and caster.mana >= caster.max_mana:
		print("Already at full mana!")
		caster.OnAlreadyFull.emit(Enums.Attribute.MANA)
		return false

	if action.mana_cost > 0 and action.mana_cost > caster.mana:
		print("Not enough mana!")
		caster.OnNotEnough.emit(Enums.Attribute.MANA)
		return false

	return true

func _check_count(action: CombatAction, _caster: Character) -> bool:
	if action.item_count > 0:
		return true
	return false

func _calculate_damage(action: CombatAction, caster: Character, opponent: Character) -> int:
	var base_damage: int = randi_range(action.min_dmg, action.max_dmg)
	var advantage: int
	var coefficient: float
	
	if action.type == Enums.CombatActionType.SPELL:
		advantage = caster.spell_power - opponent.magic_resistance
		if advantage > 0:
			coefficient = Coefficients.spell_power_coef
		elif advantage < 0:
			coefficient = Coefficients.magic_resistance_coef
		else:
			coefficient = 0
	else:
		advantage = caster.attack - opponent.defense
		if advantage > 0:
			coefficient = Coefficients.attack_coef
		elif advantage < 0:
			coefficient = Coefficients.defense_coef
		else:
			coefficient = 0

	var damage_dealt: float = base_damage * (1 + advantage * coefficient)
	return int(roundf(damage_dealt))
