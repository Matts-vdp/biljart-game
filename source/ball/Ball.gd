extends RigidBody2D

signal scored

export var power = 1.5
var stopped = true
export var thres = 2
export var thresSc = 0.1
var scored
onready var spr = $Sprite

func _physics_process(delta):
    if scored:
        spr.scale = spr.scale * 0.95
        if spr.scale.length() < thresSc:
            emit_signal("scored")
            delete()
    else:  
        if linear_velocity.length() < 10:
            linear_damp = 3
        else:
            linear_damp = 0.8
    if linear_velocity.length() > thres:
        stopped = false
    else:
        stopped = true

func delete():
    queue_free()

func score():
    linear_damp = 200
    scored = true
   
func fire(dir):
    if stopped:
        apply_impulse(Vector2.ZERO, dir * power)
