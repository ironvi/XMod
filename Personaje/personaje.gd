extends CharacterBody3D

var velocidad:int = 200
var gravedadV:float = 9.8
@export_range(0.0, 1.0) var sensibilidad_H:float = 0.02
@export_range(0.0, 1.0) var sensibilidad_V:float = 0.02
@onready var camera:Camera3D = $Camera3D
var movimiento_Aire = 50
var ui_Cancel:String = "ui_cancel"
var ClickIzq:String = "ClickIzq"
var Derecha:String = "Derecha"
var Izquierda:String = "Izquierda"
var Atras:String = "Atras"
var Adelante:String = "Adelante"


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity = get_gravity() * gravedadV * delta
	
	# Configuracion solo para PC
	if Input.is_action_just_pressed(ui_Cancel):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#-----------------------------------------------------
	
	#Configuracion solo para PC
	if Input.is_action_pressed(ClickIzq):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# ----------------------------------------------------

	var direccion:Vector3 = Vector3.ZERO
	
	# Configuracion del movimiento par PC y Consolas
	direccion = transform.basis * -Vector3(Input.get_axis(Derecha, Izquierda), 0, Input.get_axis(Atras, Adelante)).normalized()
	# -----------------------------------------------------------------------------------------------------------------------------
	
	if is_on_floor():
		velocity.x = direccion.x * velocidad * delta
		velocity.z = direccion.z * velocidad * delta
	else:
		velocity.x = direccion.x * movimiento_Aire * delta
		velocity.z = direccion.z * movimiento_Aire * delta
	
	move_and_slide()
	
func _input(event:InputEvent):
	
	# configuracion de la camara solo para PC
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensibilidad_H))
		camera.rotate_x(deg_to_rad(-event.relative.y * sensibilidad_V))
	# ---------------------------------------------------------------------
