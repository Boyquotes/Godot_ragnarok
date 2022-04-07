extends Node2D

enum states {
	menu_start,
	menu,
	game_transition,
	game_start,
	game,
	pause,
}
var level1 = preload("res://scenes/map/ElfForest.tscn")
var current_level : Node

var main_menu = preload("res://scenes/menu/StartMenu.tscn").instance()
var current_state = states.menu

func _ready() -> void:
	add_child(main_menu)

func get_input() -> void:
	if Input.is_action_just_pressed("Escape") && current_state == states.game:
		$PauseMenu.set_visible(true)
		current_state = states.pause
		get_tree().paused = true
	if Input.is_action_just_pressed("CharMenu") && current_state == states.game:
		$CharacterMenu.set_visible(true)
		current_state = states.pause
		get_tree().paused = true
	elif (Input.is_action_just_pressed("Escape") ||
	Input.is_action_just_pressed("CharMenu")) && current_state == states.pause:
		current_state = states.game
		$CharacterMenu.set_visible(false)
		$PauseMenu.set_visible(false)
		get_tree().paused = false
	
func _process(delta) -> void:
	get_input()
	
	match current_state:
		states.game_start:
			remove_child(main_menu)
			current_level = level1.instance()
			$LevelHandler.add_child(current_level)
			current_state = states.game
		states.menu_start:
			add_child(main_menu)
			current_state = states.menu

func _on_TransitionScreen_transitioned() -> void:
	if (current_state == states.game_transition):
		current_state = states.game_start

func game_start() -> void:
	current_state = states.game_transition
	$TransitionScreen.transition()

func _on_PauseMenu_quited() -> void:
	$LevelHandler.remove_child(current_level)
	current_state = states.menu_start
	$PauseMenu.set_visible(false)
	get_tree().paused = false

func _on_PauseMenu_resumed() -> void:
	$PauseMenu.set_visible(false)
	current_state = states.game
	get_tree().paused = false
