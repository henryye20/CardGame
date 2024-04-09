extends Node

#events that should b accessed everywhere

#card events 
signal card_drag_started(card_ui:CardUI)
signal card_drag_ended(card_ui:CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card:Card)
signal card_tooltip_requested(card:Card)
signal tooltip_hide_requested()

signal double_played
signal gamble_played

#player events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
signal player_hit
signal player_died
signal player_stats(run)
signal art_enable

#Enemy events
signal enemy_action_completed(enemy:Enemy)
signal enemy_turn_ended

#battle events
signal battle_over_screen_requested(text:String,type:BattleOverPanel.Type)
signal battle_won
signal battle_start

#battle reward events
signal battle_reward_exited


