extends CanvasLayer
class_name MenuManager

onready var states = {
	BaseMenu.State.Unpaused: $Unpaused,
	BaseMenu.State.Paused: $PauseMenu,
}

var currentMenu: BaseMenu
var previousMenu: BaseMenu


func _ready() -> void:
	menu_hid()
	change_menu(BaseMenu.State.Unpaused)

func _input(event: InputEvent) -> void:
	var newMenu = currentMenu.handle_input(event)
	if newMenu != BaseMenu.State.Null:
		change_menu(newMenu)


func change_menu(newMenu: int) -> void:
	print(currentMenu)
	print(newMenu)
	if currentMenu:
		currentMenu.exit()
		previousMenu = currentMenu

	currentMenu = states[newMenu]
	currentMenu.enter()


func menu_hid() -> void:
	for child in get_children():
		child.visible = false 
