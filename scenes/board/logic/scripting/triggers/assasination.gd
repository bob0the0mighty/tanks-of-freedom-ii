extends "res://scenes/board/logic/scripting/triggers/base_trigger.gd"

var vip_id = null

func _init():
    self.observed_event_type = ['unit_destroyed']

func _observe(event):
    if event.unit_id == self.vip_id:
        self.execute_outcome(event)

func _get_outcome_metadata(event):
    return {
        'player_id' : self.board.state.get_player_id_by_side(event.unit_side),
        'side' : event.unit_side,
        'attacker' : event.attacker
    }

func ingest_details(details):
    self.vip_id = self.board.map.model.get_tile2(details['vip'][0], details['vip'][1]).unit.tile.get_instance_id()
