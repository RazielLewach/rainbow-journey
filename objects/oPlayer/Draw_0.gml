#region Crea el modelo de la cabeza de la medusa.
	if (vertexJellyfishHead == noone) {
		vertexJellyfishHead = vertex_create_buffer();
		vertex_begin(vertexJellyfishHead,oControl.vertexFormat);
			// El núcleo.
			var _r = radius, _v = vertexJellyfishHead, _c = oControl.colorFinalEssence;
			setArrD3dOpciones(0,0,0,0,0,180,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*0.6,-90,+90,true,9,oControl.colorFinalEssence,1,0.0,0.0,0.01,0.01);
			
			// La cáscara.
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*1.0,-90,+0,false,18,c_gray,1,0.0,0.0,5.0,1.0);
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*1.0,-90,+0,true,18,_c,1,0.0,0.0,5.0,1.0);
			
			// Los 5 brazos exteriores.
			for (var i = 0; i < 360; i += 360/5)
			{
				var _dir = i+180;
				var _x = +_r*1.00*dcos(_dir);
				var _y = -_r*1.00*dsin(_dir);
				
				setArrD3dOpciones(_x,_y,0,0,0,0,_dir+90,1,1,1);
				
				// TRIANGULITO TAPAR AGUJERO
				// Left top
				/*d3dAddTrioVertex(_v,_c,1,
					-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50,
					-_r*0.30,-_r*0.10,+_r*0.00,0.25,0.50,
					+_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50
				);*/
				
				// FRONT
				// Left top
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,+3,+0],
					[-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50, -1,+3,+0],
					[+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0],
					[+_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50, +0,+3,-1]
				);
				// Right top
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50, +1,+3,+0],
					[+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50, +1,+3,+0],
					[-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +0,+3,-1]
				);
				// Left bot
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,+3,+1],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,+3,+0],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,+3,+1],
					[+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0]
				);
				// Right bot
				d3dAddQuadraVertexArray(_v,_c,1,
					[-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, -0,+3,+1],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,+3,+0],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,+3,+1],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,+1,+0]
				);
				
				// BACK
				// Right top
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,-3,+0],
					[+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50, +1,-3,+0],
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, +0,-1,+0],
					[+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50, +0,-3,-1]
				);
				// Left top
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50, -1,-3,+0],
					[-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50, -1,-3,+0],
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, -0,-1,+0],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -0,-3,-1]
				);
				// Right bot
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,-3,+1],
					[+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,-3,+0],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,-3,+1],
					[-_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, +0,-1,+0]
				);
				// Left bot
				d3dAddQuadraVertexArray(_v,c_gray,1,
					[+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, -0,-3,+1],
					[-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,-3,+0],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,-3,+1],
					[-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,-1,+0]
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
		setShaderParameterVec(shJellyfishFlux,"uLight",[oLight.x, oLight.y, oLight.z]);
		setShaderParameterVec(shJellyfishFlux,"uOrigin",[x, y, z]);
		setShaderParameterFloat(shJellyfishFlux,"dirSpeed",dirSpeed);
		
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
		
		// El palo.
		var _rat = _r*0.1;
		for (var i = 0; i < 25; ++i)
		{
			setArrD3dOpciones(0,0,-_r*i/5,0,0,+90,0,1,1,1);
			d3dAddPipe(_v,0,0,0,_rat,_rat,_r/5,true,false,36,_c,1,0.0,0.0,0.5,1.0);
		}
		
		setArrD3dOpciones(0,0,-_r*5,0,16,0,0,1,1,1);
		d3dAddSphere(_v,10,0,0,_rat,-90,+90,true,36,_c,1,0.0,0.0,0.5,1.0);
		
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
				var _xDraw = other.x+_coords[0];
				var _yDraw = other.y+_coords[1];
				var _zDraw = other.z+_coords[2];
				
				shader_set(shJellyfishTentacle);
				for (var j = 0; j < array_length(arrDirPhi); ++j)
				{
					setShaderParameterVec(shJellyfishTentacle,"uLight",[oLight.x, oLight.y, oLight.z]);
					setShaderParameterVec(shJellyfishTentacle,"uOrigin",[_xDraw, _yDraw, _zDraw]);
					setShaderParameterFloat(shJellyfishTentacle,"uPhi"+string(j),0)//-angle_difference(other.dirPhiLook,arrDirPhi[j])/30);
					setShaderParameterFloat(shJellyfishTentacle,"uTheta"+string(j),0)//-angle_difference(other.dirThetaLook,arrDirTheta[j])/30);
				}
				
				matrix_set(matrix_world,matrixBuildExt(_xDraw, _yDraw, _zDraw, 0, other.dirThetaLook-90, other.dirPhiLook,1,1,1));
				vertex_submit(other.vertexJellyfishTentacle,pr_trianglelist,other.txJellyfishTentacle);
				
				shader_reset();
			}
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion