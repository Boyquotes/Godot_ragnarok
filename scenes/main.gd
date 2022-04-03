extends Node2D

enum states {
	menu,
	game_transition,
	game_start,
	game
}

var current_state = states.menu

func _ready():
	pass # Replace with function body.

func _process(delta):
	match current_state:
		states.game_start:
			remove_child($StartMenu)
			var level1 = load("res://scenes/ElfForest.tscn")
			add_child(level1.instance())
			current_state = states.game

func _on_TransitionScreen_transitioned():
	if (current_state == states.game_transition):
		current_state = states.game_start

func game_start():
	current_state = states.game_transition
	$TransitionScreen.transition()
