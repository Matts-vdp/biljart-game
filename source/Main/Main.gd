extends Node2D

onready var spawn = $spawn
onready var aim = $Aim
var ball = preload("res://ball/Ball.tscn")
var whiteBall
onready var balls = $Balls
var pressed = false
var clickpos

func _ready():
    spawnBall()
    balls.reset()

func reset():
    whiteBall.delete()
    spawnBall()
    balls.reset()

func spawnBall():
    var b = ball.instance()
    b.position = spawn.position
    whiteBall = b
    b.connect("scored", self, "spawnBall")
    add_child(b)


func _input(event):
    if event is InputEventMouseButton:
        if !pressed:
            clickpos = event.position
            drawAim(event.position)
        else:
            fire(event.position)
        pressed = !pressed
        aim.visible = pressed && whiteBall.stopped
    elif event is InputEventMouseMotion:
        if pressed && whiteBall.stopped:
            drawAim(event.position)
            aim.visible = pressed && whiteBall.stopped

func fire(pos):
    var dir = pos.direction_to(clickpos)
    dir *= pos.distance_to(clickpos)
    whiteBall.fire(dir)
    

func drawAim(pos):
    var dir = pos.direction_to(clickpos)
    var leng = pos.distance_to(clickpos) * 0.4 + 50
    var tar = whiteBall.position + dir * leng
    aim.clear_points()
    aim.add_point(whiteBall.position)
    aim.add_point(tar)

func _on_Map_hit(body):
    body.score()


func _on_Balls_done():
    reset()
