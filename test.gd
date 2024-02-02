extends Node2D
var curve: Curve2D

# Called when the node enters the scene tree for the first time.
func _ready():
	curve = Curve2D.new()
	curve.add_point(Vector2(50, 50))
	var path2D : Path2D = $Path2D
	path2D.set_curve(curve)

	var l := Line2D.new()   
	l.default_color = Color(1,1,1,1)  
	l.width = 1 
	for point in curve.get_baked_points():  
		l.add_point(point)
	add_child(l)
		

var inc = 0
var speed = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (Input.is_action_just_pressed("attack")):
		curve.remove_point(1)
		curve.add_point(get_local_mouse_position(), Vector2(0,0), Vector2(0,0), 1)
		inc = 0
	$Path2D/PathFollow2D/Sprite2D.rotation += delta * 10
	inc += delta * speed
	$Path2D/PathFollow2D.progress = inc
	if ($Path2D/PathFollow2D.progress_ratio > 0.9):
		$Path2D/PathFollow2D.progress_ratio = 0
		curve.remove_point(1)
		
	pass
