#region Dibuja suelo de testeo (TESTING).
	var _w = 512*20;
	for (var i = -_w*10; i <= _w*10; i += _w)
		for (var j = -_w*10; j <= _w*10; j += _w)
			draw_sprite_ext(sGrid,0,i,j,20,20,0,c_gray,0.5);
#endregion