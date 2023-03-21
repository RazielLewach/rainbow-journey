#region Crea y dibuja el modelo de la cabeza de la medusa.
	if (vertexJellyfishHead == noone) {
		vertexJellyfishHead = vertex_create_buffer();
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		vertex_begin(vertexJellyfishHead,oControl.vertexFormat);
			// El núcleo.
			var _r = radius, _v = vertexJellyfishHead, _c = oControl.colorFinalEssence;
			d3dAddSphere(_v,0,0,-_r*0.4,_r*0.3,-90,+90,true,36,oControl.colorFinalEssence,1,0.0,0.0,0.01,0.01);
			
			// La cáscara.
			setArrD3dOpciones(0,0,0,0,0,0,36,1,1,1);
			d3dAddSphere(_v,0,0,-_r*0.3,_r*1.0,-90,+0,false,36,c_gray,1,0.0,0.0,5.0,0.84);
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			d3dAddSphere(_v,0,0,-_r*0.3,_r*1.0,-90,+0,true,36,_c,1,0.0,0.0,5.0,0.84);
			
			// Los 5 brazos exteriores.
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			for (var i = 0; i < 360; i += 360/5)
			{
				var _dir = i+180;
				var _x = +_r*0.95*dcos(_dir);
				var _y = -_r*0.95*dsin(_dir);
				
				setArrD3dOpciones(_x,_y,0,0,0,0,_dir+90,1,1,1);
				// FRONT
				// Left top
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75],
					[-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50],
					[+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75],
					[+_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50]
				);
				// Right top
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50],
					[+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50],
					[-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75]
				);
				// Left bot
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75]
				);
				// Right bot
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00]
				);
				
				// BACK
				// Right top
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75],
					[+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50],
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75],
					[+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50]
				);
				// Left top
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50],
					[-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50],
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75]
				);
				// Right bot
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[-_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75]
				);
				// Left bot
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00]
				);
			}
			
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		vertex_end(vertexJellyfishHead);
		vertex_freeze(vertexJellyfishHead);
	}
	if (vertexJellyfishHead != noone) {
		shader_set(shJellyfishFlux);
		setShaderParameterFloat(shJellyfishFlux,"scaling",dcos(dirSpeed));
		var _scH = 1.0+0.2*dcos(dirSpeed);
		var _scV = 1.0+0.4*dsin(dirSpeed);
		matrix_set(matrix_world,matrixBuildExt(x,y,z,0,dirThetaLook-90,dirPhiLook,_scH,_scH,_scV));
		vertex_submit(vertexJellyfishHead,pr_trianglelist,txJellyfishSkin);
		shader_reset();
	}
#endregion
#region Crea y dibuja los modelos de los tentáculos de la medusa.
	if (vertexJellyfishTentacle == noone) {
		vertexJellyfishTentacle = vertex_create_buffer();
		
		vertex_begin(vertexJellyfishTentacle,oControl.vertexFormat);
		
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		d3dAddSphere(_v,0,0,-_r*0.3,_r*1.0,-90,+0,true,36,_c,1,0.0,0.0,5.0,0.84);
		
		vertex_end(vertexJellyfishTentacle);
		vertex_freeze(vertexJellyfishTentacle);
	}
	if (vertexJellyfishTentacle != noone) {
		matrix_set(matrix_world,matrixBuildExt(x,y,z,0,dirThetaLook-90,dirPhiLook,_scH,_scH,_scV));
		vertex_submit(vertexJellyfishTentacle,pr_trianglelist,txJellyfishTentacle);
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion