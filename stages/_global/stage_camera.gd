class_name StageCamera extends Camera2D

@export var padding: float = 100
@export var min_zoom = 1.5
@export var max_zoom = 4.0

const zoomSpeed = 2.0

func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = 15

func _physics_process(delta: float) -> void:
	var player_positions = []
	for fighter in StageUtils.getFighters():
		if !fighter.hideCamera:
			var pos = fighter.position
			player_positions.append(pos)
				
	if player_positions.size() == 0:
		return
	var min_x = player_positions[0].x
	var min_y = player_positions[0].y
	var max_x = player_positions[0].x
	var max_y = player_positions[0].y

	# Find the bounding rectangle
	for pos in player_positions:
		min_x = min(min_x, pos.x)
		min_y = min(min_y, pos.y)
		max_x = max(max_x, pos.x)
		max_y = max(max_y, pos.y)

	var center = Vector2(
	(min_x + max_x) / 2,
	(min_y + max_y) / 2
	)
	global_position = center
	var bounds = Vector2(max_x - min_x, max_y - min_y)
	bounds += Vector2(padding * 2, padding * 2)
	var viewport_size = get_viewport_rect().size

	var zoom_x = bounds.x / viewport_size.x
	var zoom_y = bounds.y / viewport_size.y
	var final_zoom = 1 / max(zoom_x, zoom_y)
	final_zoom = clamp(final_zoom, min_zoom, max_zoom)

	zoom = zoom.lerp(Vector2(final_zoom, final_zoom), zoomSpeed * delta)
