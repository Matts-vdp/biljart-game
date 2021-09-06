extends Node2D

var balls = []
var ball = preload("res://ball/Ball.tscn")
signal done

func _ready():
    for child in get_children():
        balls.append({"color": child.modulate, "pos": child.position})

func spawnBall(b):
    var new = ball.instance()
    new.modulate = b["color"]
    new.position = b["pos"]
    new.connect("scored", self, "ballScore")
    add_child(new)

func ballScore():
    if get_child_count() == 0:
        emit_signal("done")

func reset():
    for child in get_children():
        child.delete()
    for b in balls:
        spawnBall(b)

