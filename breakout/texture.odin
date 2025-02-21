package main

import gl "vendor:OpenGL"

Texture2D :: struct {
	id:              u32,
	width:           i32,
	height:          i32,
	internal_format: i32,
	image_format:    u32,
	wrap_s:          i32,
	wrap_t:          i32,
	filter_min:      i32,
	filter_max:      i32,
}


init_texture :: proc(texture: ^Texture2D) {
	gl.GenTextures(1, &texture.id)
}

// "textures/container.jpg"
generate_texture :: proc(texture: ^Texture2D, width: i32, height: i32, data: [^]u8) {
	texture.width = width
	texture.height = height
	bind_texture(texture)

	gl.TexImage2D(
		gl.TEXTURE_2D,
		0,
		texture.internal_format,
		texture.width,
		texture.height,
		0,
		texture.image_format,
		gl.UNSIGNED_BYTE,
		data,
	)

	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, texture.wrap_s)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, texture.wrap_t)

	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, texture.filter_min)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, texture.filter_max)

	// Unbind
	gl.BindTexture(gl.TEXTURE_2D, 0)
}


bind_texture :: proc(texture: ^Texture2D) {
	gl.BindTexture(gl.TEXTURE_2D, texture.id)
}
