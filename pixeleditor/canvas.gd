extends Sprite2D

## !! important notice !! this file has issues listed in the uypues.txt

@export var image:Image = Image.create(16,16,true,Image.FORMAT_RGBA4444);
var displayTexture:ImageTexture

var imageSize := 8; # set this to the *ideal* value, but upscale it by 1 because of issues listed in the uypues.txt
var zoomingFactor = 0.3;
var tweeningSpeed = 0.1; # in seconds
var zoomInfo:String;

# panning
var panning:bool = false;

# can be used in many unrelated mouse actions (panning, zooming, etc.)
var initialPos:Vector2;
var initialCameraPos:Vector2;
var initialScale:Vector2;

var old_pos:Vector2;

## boring stuff

func _ready() -> void:
	imageSize += 1; ## look at uypues.txt issue no. 1 for more info
	image = Image.create(imageSize, imageSize, true, Image.FORMAT_RGBA8);
	#outline
	%outline.add_point(Vector2(0.5,0.5));
	%outline.add_point(Vector2(imageSize -0.5, 0.5))
	%outline.add_point(Vector2(imageSize -0.5, imageSize-0.5))
	%outline.add_point(Vector2(0.5, imageSize-0.5));
	%outline.add_point(Vector2(0.5,0.5));
	#grid
	%pixel_grid.scale = Vector2(imageSize-1, imageSize-1);
	%pixel_grid.position += Vector2((imageSize+0.000)/2, (imageSize+0.000)/2);
	%pixel_grid.material.set_shader_parameter("grid_size", 1000/(imageSize-1))
	%transparency_grid.scale = Vector2(imageSize-1, imageSize-1);
	%transparency_grid.position += Vector2((imageSize + 0.000)/2, (imageSize + 0.000)/2)
	create_image()
	%addTimer.start();
	
func create_image() -> void:
	displayTexture = ImageTexture.create_from_image(image);
	texture = displayTexture;

func center() -> void:
	%camera.position.x = imageSize/2;
	%camera.position.y = imageSize/2;
	%camera.offset = Vector2(0,0);
	pass
	
func relocate() -> void:
	%camera.zoom = Vector2(30,30);
	center();
	initialScale = %camera.zoom

func _on_recenter_pressed() -> void:
	relocate();

func _on_add_timer_timeout() -> void:
	relocate();

## drawing stuff

func _process(delta: float) -> void:
	if panning:
		pan(get_viewport().get_camera_2d().get_global_mouse_position())
	else:
		if Input.is_action_just_pressed("mouse_down"):
			old_pos = get_local_mouse_position() + Vector2(0.5, 0.5)
		if Input.is_action_pressed("mouse_down"):
			drawPixel(old_pos, get_local_mouse_position() + Vector2(0.5, 0.5))
			old_pos = get_local_mouse_position() + Vector2(0.5,0.5)
	var mousePos = get_viewport().get_camera_2d().get_local_mouse_position()
	%zoomInfo.text = zoomInfo + "mouse (" + str(int(mousePos.x)) + ", " + str(int(mousePos.y)) + ")";

func drawPixel(old_position:Vector2, position:Vector2):
	position = Vector2i(position)
	old_position = Vector2i(old_position)
	drawLine(image, old_position, position, PixelEditor.current_color)
	update_image()

func safeSetPixel(img: Image, x: int, y: int, color: Color):
	if x < img.get_size().x and x > 0:
		if y < img.get_size().y and y > 0:
			img.set_pixel(x, y, color)

func drawLine(img: Image, start: Vector2i, end: Vector2i, color: Color):
	var delta: Vector2i = end - start
	var abs_delta = abs(delta)
	var sign_delta = sign(delta)
	if abs_delta.x >= abs_delta.y:
		for i in range(abs_delta.x):
			safeSetPixel(img, start.x + i * sign_delta.x, round(lerp(float(start.y), float(end.y), float(i) / abs_delta.x)), color)
	else:
		for i in range(abs_delta.y):
			safeSetPixel(img, round(lerp(float(start.x), float(end.x), float(i) / abs_delta.y)), start.y + i * sign_delta.y, color)
	safeSetPixel(img, start.x, start.y, PixelEditor.current_color)
	safeSetPixel(img, end.x, end.y, PixelEditor.current_color)

func update_image() -> void:
	# displayTexture is of type "ImageTexture"
	displayTexture.update(image);
	# the "texture" attribute of the sprite2d is dynamically loaded to displayTexture

## moving around stuff

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("maximize"):
		zoom(true, get_viewport().get_camera_2d().get_local_mouse_position())
	if event.is_action_pressed("minimize"):
		zoom(false, get_viewport().get_camera_2d().get_local_mouse_position())
	# pan functionality
	if event.is_action_pressed("pan"):
		initialPos = get_viewport().get_camera_2d().get_global_mouse_position()
		initialCameraPos = %camera.position;
		panning = true;
	if event.is_action_released("pan"):
		panning = false

func zoom(direction:bool, mousePos:Vector2): # maximizing is true, minimizing is false
	var zoom:Vector2 = %camera.zoom;
	var newZoom:Vector2;
	var offset:Vector2 = %camera.offset;
	var newOffset:Vector2;
	if direction:
		newZoom = zoom*(1 + zoomingFactor);
		newOffset = mousePos/3
	else:
		newZoom = zoom*(1 - zoomingFactor);
		newOffset = +mousePos/3
	var tween := create_tween().set_parallel()
	tween.tween_property(%camera, "zoom", newZoom, tweeningSpeed);
	tween.tween_property(%camera, "offset", newOffset, tweeningSpeed)
	tween.tween_callback(func(): zoomInfo = "zoom (" + str(int(newZoom.x)) + ", " + str(int(newZoom.y)) + ")")

func pan(pos:Vector2):
	%camera.position = initialCameraPos + pos.lerp(initialPos, 0.4)
