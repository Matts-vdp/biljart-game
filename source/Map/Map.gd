extends Sprite

signal hit 

func _on_Holes_body_entered(body):
    emit_signal("hit", body)
