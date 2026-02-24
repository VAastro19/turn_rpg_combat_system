# enums.gd
extends Node

enum CombatActionType {MAIN, SPELL, ABILITY, ITEM}

enum CombatActionMelee {NONE, ATTACK, HEAVY_ATTACK, WAIT}

enum CombatActionSpells {NONE, HEAL, FIREBALL, LIGHTNING}

enum CombatActionAbilities {NONE, FOCUS_ENERGY, GUARD}

enum CombatActionItems {NONE, HEALTH_POTION, STAMINA_POTION, MANA_POTION}

enum Attribute {HEALTH, STAMINA, MANA}
