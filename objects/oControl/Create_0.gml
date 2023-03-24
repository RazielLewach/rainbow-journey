#region Vertex format.
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	vertex_format_add_normal();
	vertexFormat = vertex_format_end();
#endregion
#region Inicialización.
	create(room_width/2,room_height/2,oPlayer);
	create(room_width/2,room_height/2,oCamera);
	create(room_width/2,room_height/2,oTrucos);
	create(room_width/2,room_height/2,0,oLight);
	window_set_fullscreen(true);
	gpu_set_texrepeat(true);
	randomize();
	draw_set_color(c_white);
	draw_set_circle_precision(60);
	window_set_cursor(cr_none);
	depth = 10;
	gpu_set_cullmode(cull_counterclockwise);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	gpu_set_ztestenable(true);
	matTransformacion = noone; // La matriz nomás. Incluye translación.
	matTransformacionNormal = noone; // Sin translaciones, para normales.
#endregion
#region Enums (async).
	// General.
	enum MODE {NOONE, JELLYFISH}
#endregion
#region Macros (async).
	// General.
	#macro FPS 60 // Frames per second del juego.
	#macro INFINITE 9999999 // Pos el infinito.
	
	// Escenario.
	#macro MAX_WATER_HEIGHT 100000 // Altura máxima.
#endregion
#region Parámetros a guardar (async).
	colorHueEssence = 255; // Tu color de esencia.
	scCameraPrecision = 0.07; // Velocidad de movimiento de la cámara.
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
	colorFinalEssence = make_color_hsv(colorHueEssence,255,255);
#endregion
#region Vertex y textures.
	//txBlank = sprite_get_texture(sBlank,0); // Blanco.
#endregion