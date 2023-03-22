#region Crea el modelo de la cabeza de la medusa.
	if (vertexJellyfishHead == noone) {
		vertexJellyfishHead = vertex_create_buffer();
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		vertex_begin(vertexJellyfishHead,oControl.vertexFormat);
			// El núcleo.
			var _r = radius, _v = vertexJellyfishHead, _c = oControl.colorFinalEssence;
			d3dAddSphere(_v,0,0,-_r*0.4,_r*0.6,-90,+90,true,36,oControl.colorFinalEssence,1,0.0,0.0,0.01,0.01);
			
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
#endregion
#region Dibuja el modelo de la cabeza de la medusa.
	var _scH = 1.0+0.2*dcos(dirSpeed);
	var _scV = 1.0+0.4*dsin(dirSpeed);
	if (vertexJellyfishHead != noone) {
		shader_set(shJellyfishFlux);
		setShaderParameterFloat(shJellyfishFlux,"scaling",dcos(dirSpeed));
		matrix_set(matrix_world,matrixBuildExt(x,y,z,0,dirThetaLook-90,dirPhiLook,_scH,_scH,_scV));
		vertex_submit(vertexJellyfishHead,pr_trianglelist,txJellyfishSkin);
		shader_reset();
	}
#endregion
#region Crea los modelos de los tentáculos de la medusa.
	if (vertexJellyfishTentacle == noone) {
		vertexJellyfishTentacle = vertex_create_buffer();
		
		vertex_begin(vertexJellyfishTentacle,oControl.vertexFormat);
		
		var _r = radius, _v = vertexJellyfishTentacle, _c = oControl.colorFinalEssence;
		setArrD3dOpciones(0,0,0,0,0,0,0,1,0.05,1);
		for (var i = 0; i < 30; ++i)
			d3dAddSphere(_v,-_r*0.2*i,0,0,_r*0.13,-90,+90,true,36,_c,1,0.0,0.0,1.0,1.0);
		
		vertex_end(vertexJellyfishTentacle);
		vertex_freeze(vertexJellyfishTentacle);
	}
#endregion
#region Dibuja los modelos de los tentáculos de la medusa.
	if (vertexJellyfishTentacle != noone) {
		var _lon = radius*0.45;
		for (var i = 0; i < array_length(arrTentaculo); ++i)
			with(arrTentaculo[i])
			{
				var _dirPhi = i*72;
				var _coords = matrix_transform_vertex(
					matrixBuildExt(0,0,0,0,other.dirThetaLook-90,other.dirPhiLook,_scH,_scH,_scV),
					+_lon*dcos(_dirPhi),-_lon*dsin(_dirPhi),0
				);

				shader_set(shJellyfishTentacle);
				for (var j = 0; j < array_length(arrDirPhi); ++j)
				{
					setShaderParameterFloat(shJellyfishTentacle,"phi"+string(j),-angle_difference(other.dirPhiLook,arrDirPhi[j])/10);
					setShaderParameterFloat(shJellyfishTentacle,"theta"+string(j),angle_difference(other.dirThetaLook,arrDirTheta[j])/10);
				}
				matrix_set(matrix_world,matrixBuildExt(
					other.x+_coords[0],
					other.y+_coords[1],
					other.z+_coords[2],
				0, other.dirThetaLook, other.dirPhiLook,1,1,1));
				vertex_submit(other.vertexJellyfishTentacle,pr_trianglelist,other.txJellyfishTentacle);
				shader_reset();
			}
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion