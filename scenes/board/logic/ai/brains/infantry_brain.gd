extends "res://scenes/board/logic/ai/brains/abstract_unit_brain.gd"

func _gather_ability_actions(entity_tile, ap, board):
    var unit = entity_tile.unit.tile

    if not unit.has_moves():
        return []

    if not unit.has_active_ability():
        return []

    var actions = []
    var action
    var tiles_in_range = []
    var targets_in_range = []

    for ability in unit.active_abilities:
        if ability.is_visible() and ability.ap_cost <= ap and not ability.is_on_cooldown():
            targets_in_range = []

            tiles_in_range = board.ability_markers.get_all_tiles_in_ability_range(ability, entity_tile)

            for tile in tiles_in_range:
                if ability.is_tile_applicable(tile, entity_tile):
                    targets_in_range.append(tile)

            for target_tile in targets_in_range:
                action = self._ability_action(ability, target_tile)
                ability.active_source_tile = entity_tile
                action.delay = 0.5
                action.value = target_tile.unit.tile.unit_value + 50
                actions.append(action)

    return actions
