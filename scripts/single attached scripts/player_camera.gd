extends Camera2D

var nShake: int = 0
var shakeDuration: float = 0.1
var shakeIntensity: float = 1.5
var backToNormalTime: float = 0.1

func camera_shake() -> void:
	nShake = 60
	$tright.start(shakeDuration/nShake)

func _on_timer_timeout(t: Timer, dir: int) -> void:
	offset.x += shakeIntensity * dir
	nShake -= 1
	t.stop()
	if nShake <= 0:
		var tween: Tween = create_tween()
		tween.tween_property(self, "offset", Vector2.ZERO, backToNormalTime)
		return
	if nShake % 10 > 4: $tright.start(shakeDuration/nShake)
	else: $tleft.start(shakeDuration/nShake)
