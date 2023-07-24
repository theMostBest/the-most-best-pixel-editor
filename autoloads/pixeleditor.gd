extends Node

var current_color:Color = Color.BLACK;

var tool_width:int;
var fill_threshold:float = 0.99

var toolbarState:int;
enum toolbarStates {
	DRAW,
	FILL,
	ERASE,
}
