#region Dibuja suelo de testeo (TESTING).
	//var _w = 512*20;
	//for (var i = -_w*10; i <= _w*10; i += _w)
		//for (var j = -_w*10; j <= _w*10; j += _w)
	var _w = 512;
	for (var i = _w/2; i < room_width-_w/2; i += _w)
		for (var j = _w/2; j < room_height-_w/2; j += _w)
			draw_sprite_ext(sGrid,0,i,j,1,1,0,c_gray,0.5);
#endregion
#region Modelo 3D de esfera, plantilla.
	if (vertexSphere == noone) {
		vertexSphere = vertex_create_buffer();
		
		vertex_begin(vertexSphere,vertexFormat);
		
	
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		d3dAddSphere(vertexSphere,0,0,0,1,-90,+90,true,10,c_white,1,0.0,0.0,1.0,1.0);
		
		vertex_end(vertexSphere);
		vertex_freeze(vertexSphere);
	}
#endregion