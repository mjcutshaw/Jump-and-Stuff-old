extends CanvasLayer
class_name MenuManager


onready var states = {
	BaseMenu.State.Unpaused: $Unpaused,
	BaseMenu.State.Paused: $PauseMenu,
	BaseMenu.State.Settings: $SettingsMenu,
}

var currentMenu: BaseMenu
var previousMenu: BaseMenu


func _ready() -> void:
	menu_hid()
	change_menu(BaseMenu.State.Unpaused)
	EventBus.connect("menuChanged", self, "button_pressed")
	#LOOKAT: why does this have to be on ready instead of init. like player state machine


func _input(event: InputEvent) -> void:
	var newMenu = currentMenu.handle_input(event)
	if newMenu != BaseMenu.State.Null:
		change_menu(newMenu)


func button_pressed(menu) -> void:
	print(menu)
	change_menu(menu)


func change_menu(newMenu: int) -> void:
	if currentMenu:
		currentMenu.exit()
		previousMenu = currentMenu

	currentMenu = states[newMenu]
	currentMenu.enter()


func menu_hid() -> void:
	for child in get_children():
		child.visible = false 
