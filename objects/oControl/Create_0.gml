#region Vertex format.
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	vertexFormat = vertex_format_end();
#endregion
#region Inicialización.
	create(room_width/2,room_height/2,oPlayer);
	create(room_width/2,room_height/2,oCamera);
	create(room_width/2,room_height/2,oTrucos);
	window_set_fullscreen(true);
	gpu_set_texrepeat(true);
	randomize();
	draw_set_color(c_white);
	draw_set_circle_precision(60);
	window_set_cursor(cr_none);
	depth = 10;
	gpu_set_cullmode(cull_counterclockwise);
	gpu_set_alphatestenable(true);
	gpu_set_zwriteenable(true);
	gpu_set_ztestenable(true);
#endregion
#region Enums (async).
	
#endregion
#region Macros (async).
	#macro FPS 60 // Frames per second del juego.
	#macro INFINITE 9999999 // Pos el infinito.
#endregion
#region Estado.
	dirAngular0001 = 0; // Dirección angular de incremento 0001.
	dirAngular0002 = 0; // Dirección angular de incremento 0002.
	dirAngular0003 = 0; // Dirección angular de incremento 0003.
	dirAngular0004 = 0; // Dirección angular de incremento 0004.
	dirAngular0005 = 0; // Dirección angular de incremento 0005.
	dirAngular001 = 0; // Dirección angular de incremento 001.
	dirAngular002 = 0; // Dirección angular de incremento 002.
	dirAngular003 = 0; // Dirección angular de incremento 003.
	dirAngular005 = 0; // Dirección angular de incremento 005.
	dirAngular007 = 0; // Dirección angular de incremento 007.
	dirAngular01 = 0; // Dirección angular de incremento 01.
	dirAngular02 = 0; // Dirección angular de incremento 02.
	dirAngular03 = 0; // Dirección angular de incremento 03.
	dirAngular05 = 0; // Dirección angular de incremento 05.
	dirAngular10 = 0; // Dirección angular de incremento 10.
	dirAngular12 = 0; // Dirección angular de incremento 15.
	nStep = 0; // Contadores.
#endregion