#region Vertex format.
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	vertex_format_add_normal();
	vertexFormat = vertex_format_end();
#endregion
#region Inicialización.
	create(x,y,oPlayer);
	create(x,y,oCamera);
	create(x,y,oTrucos);
	window_set_fullscreen(true);
	gpu_set_texrepeat(true);
	randomize();
	draw_set_color(c_white);
	draw_set_circle_precision(60);
	window_set_cursor(cr_none);
	depth = -10;
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
	#macro ROOM_SIZE 5000 // Ancho, altura y profundidad máxima.
	#macro L 50 // Longitud de los tiles.
	#macro N_TILES 100 // Número de tiles.
	
	// Player.
	#macro SEP_NODE_TENTACLE 25 // Separación entre nodos del tentáculo.
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
	matLights = array_create(70,0); // Array de luces.
	nLights = 0; // Cuántas luces.
	dirWaterWave = 0; // Ondas del agua.
	lonLight = 1000; // Longitud del cono de luz.
	angLight = 40; // Ángulo del cono de luz.
	canCreateVertex = false; // Sólo crea uno por step al inicio.
	isInDungeon = false;
#endregion
#region Vertex y textures.
	txBlank = sprite_get_texture(sBlank,0); // Blanco.
	vertexSphere = noone; // Esfera.
	vertexEnvironmentRock = noone; // Pos nomás el escenario con todos los solids de roca.
	for (var i = 0; i < sprite_get_number(sEscenarios); ++i) txEscenarios[i] = sprite_get_texture(sEscenarios,i); // Texturas de los escenarios.
	vertexFloorRock = noone; // El suelo en la pantalla de carga.
#endregion
#region Loading screen.
	iProgressLoad = -1; // Al ponerse a 0, va haciendo ++ para cargar las fases. Esto marcará el %.
	iFinalProgress = 0; // Hasta dónde carga la barra.
	iLoopLoad = 0; // Iterador de bucles en i para loads.
	jLoopLoad = 0; // Iterador de bucles en j para loads.
	kLoopLoad = 0; // Iterador de bucles en k para loads.
	arrSolids = []; // Array de dónde hay sólidos.
	textLoading = ""; // ¿Qué está loading?
	iIteratsLoad = 1; // Número de iteraciones según carga.
	arrVacuums = []; // Array de vacuums.
	nVacuums = 0; // Número de vacuums.
	nConnections = 0; // Número de conexiones a modular.
	alphaDarkness = 1; // Aparece gradualmente.
	iRoomSeeksConnection = 0; // Room que vamos buscando para conectar.
#endregion