uypues.txt - "long coding issues"

btw, if u open this file in godot(maybe other ides as well), ur able to minimize and
expand the issues. i honestly like that, but u can open this in notepad as well.

~ issues with locations ~

1. the weird offset issue with the canvas:
	
	for some reason, if i dont add offset to the canvas sprite, there appears
	to be a weird margin on the top left sides. so i added an offset, and it worked!
	
	until... i noticed that the image size decreased by ❶ pixel. ikr, s h o c k i n g.
	so i changed the code to add one pixel the imageSize in the _ready function
	to make it seem like there was no issue. 
	
	but did u rlly think the issue would go away. of course not! if u export the image,
	you will have to crop the image to 1 pixel smaller then the size the image
	"technically" is. you know what i mean, right?
	
	anyways, make sure to fix these issues.
	files with this notice: 
		canvas.gd

2. pls help me get a better zoom function:
	im not a perfect godot programmer, and i specialize in non gui things.
	if u have noticed already, my zooming in function sucks a$$, so if u can pls help me,
	make my zooming in function better
	
	files with this notice:
		canvas.gd

3. button mask is missing for the "recenter button":
	basically, the yellow button mask is missing for the "recenter button",
	it seems to be an issue related to the zooming in camera. anyways, if u know some 
	solutions pls contribute.
	
	general location:
		pixelcanvas.tscn (the scene with the pixel canvas)

4. flood filling is super slow:
	i tried many ways to flood fill, the fastest i found was recursive flood filling, but this easily
	cause a stack overflow. because of stability, i opted for a slow iterative algorithm that was safe,
	but was super slow and caused lag for images that were bigger than 300*300. pls help me and make
	a safe but fast filling algorithm. thanks!
	
	files with this notice:
		canvas.gd

~ severe issues without good solution (contributors, pls help me w these) ~

1. resizing the window causes crash:
	pretty self explanitory, resizing the window causes crash. if u know of a solution,
	please pull request me or idk, comment on the github issue.