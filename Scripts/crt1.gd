extends Node

@onready var mesh_instance: MeshInstance2D = $CanvasLayer/MeshInstance2D

func _ready() -> void:
	var screen_width = DisplayServer.window_get_size().x
	var screen_height = DisplayServer.window_get_size().y
	
	if mesh_instance.mesh is QuadMesh:
		mesh_instance.mesh.size = Vector2(screen_width, screen_height)
		mesh_instance.position = Vector2.ZERO
		mesh_instance.transform = Transform2D.IDENTITY
		
		# Pass screen size to shader
		var material = mesh_instance.material as ShaderMaterial
		if material:
			material.set_shader_parameter("screen_size", Vector2(screen_width, screen_height))
