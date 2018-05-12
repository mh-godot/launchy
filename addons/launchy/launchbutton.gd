tool
extends ToolButton

var plugin #A reference to the config dialog, provided by the EditorPlugin (plugin.gd)
var exe="" #String to editor executable
var res    #Reference to the editor's currently selected resource.

func _ready():
	self.connect("pressed", self, "_on_ToolButton_pressed")
	$PopupMenu.connect("index_pressed", self, '_launchSettings')

#For right clicking.
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		$PopupMenu.rect_global_position = self.rect_global_position
		$PopupMenu.popup()

#For left clicking.
func _on_ToolButton_pressed():
	if exe == '':
		print('Launchy: Warning, no external editor has been assigned to launch for this resource.')
	elif exe !='' and File.new().file_exists(exe):
		#Get the path to the resource on disk.
		var path = ProjectSettings.globalize_path(res.resource_path)
		OS.execute(exe, [path], false)
	else:  #Path doesn't exist?
		print("Launchy: Warning, couldn't launch external editor ", exe)

#Right-click menu selected
func _launchSettings(idx):
	plugin.c.popup_centered()