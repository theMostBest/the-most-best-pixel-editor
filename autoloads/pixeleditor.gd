extends Node

var current_color:Color = Color.BLACK;

var tool_width:int;

enum toolStates {
	DRAWING,
	FILL,
	ERASE,
}
