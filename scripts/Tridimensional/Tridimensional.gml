#region setArrD3dOpciones
	/// @func  setArrD3dOpciones(x,y,z,prephi,lambda,theta,phi,xscale,yscale,zscale)
	function setArrD3dOpciones(_x,_y,_z,_prephi,_lambda,_theta,_phi,_xs,_ys,_zs) {		
		oControl.matTransformacionNormal = matrix_multiply(
				matrix_multiply(
					matrix_multiply(
						matrix_multiply(matrix_build(0,0,0,0,0,0,_xs,_ys,_zs),
										matrix_build(0,0,0,0,0,_prephi,1,1,1)
										),
										matrix_build(0,0,0,_lambda,0,0,1,1,1)
					),
				matrix_build(0,0,0,0,-_theta,0,1,1,1)),
				matrix_build(0,0,0,0,0,_phi,1,1,1)
			)
			
		oControl.matTransformacion = matrix_multiply(
			oControl.matTransformacionNormal,
			matrix_build(_x,_y,_z,0,0,0,1,1,1)
		);
	}
#endregion
#region d3dAddVertex
	/// @func  d3dAddVertex(vertex,x,y,z,color,alpha,itexture,jtexture,iNormal,jNormal,kNormal)
	function d3dAddVertex(_vtx,_x,_y,_z,_col,_alp,_i_tex,_j_tex,_iNormal,_jNormal,_kNormal) {
		var _pos = matrix_transform_vertex(oControl.matTransformacion,_x,_y,_z);
		vertex_position_3d(_vtx,_pos[0],_pos[1],_pos[2]);
	    vertex_colour(_vtx,_col,_alp);
	    vertex_texcoord(_vtx,_i_tex,_j_tex);
		var _nor = matrix_transform_vertex(oControl.matTransformacionNormal,_iNormal,_jNormal,_kNormal);
		var _lon = sqrt(_nor[0]*_nor[0] + _nor[1]*_nor[1] + _nor[2]*_nor[2]);
		vertex_normal(_vtx, _nor[0]/_lon, _nor[1]/_lon, _nor[2]/_lon);
	}
#endregion
#region d3dAddSolidVertex
	/// @func  d3dAddSolidVertex(x,y,z,itexture,jtexture)
	function d3dAddSolidVertex(_x,_y,_z,_i_tex,_j_tex) {
		// Buscamos el vacuum más cercano y, si estamos en el borde, nos ajustamos a su radio para quitar el voxel.
		var _vac = getNearestVacuum(_x, _y, _z);
		var _phi = getPhiFromCoords(_x, _y, _vac.x, _vac.y);
		var _theta = getThetaFromCoords(_x, _y, _z, _vac.x, _vac.y, _vac.z);
		var _dcos = dcos(_x*_y*_z);
		var _lon = _vac.radius - L*0.5 + L*0.5*_dcos;
		
		// Enviamos la llamada a vertex.
		d3dAddVertex(oControl.vertexEnvironmentRock,
			_vac.x - _lon*dcos(_phi)*dcos(_theta),
			_vac.y + _lon*dsin(_phi)*dcos(_theta),
			_vac.z + _lon*dsin(_theta),
			make_color_hsv(0, 0, 130-125*_dcos), 1, _i_tex, _j_tex,
			+dcos(_phi)*dcos(_theta),
			-dsin(_phi)*dcos(_theta),
			-dsin(_theta)
		);
	}
#endregion
#region d3dAddFloorVertex
	/// @func  d3dAddFloorVertex(x,y,z,itexture,jtexture)
	function d3dAddFloorVertex(_x,_y,_z,_i_tex,_j_tex) {
		var _dcos = dcos(_x*_y);
		var _int = 1-min(1, max(0, point_distance(_x, _y, ROOM_SIZE/2, ROOM_SIZE/2) - ROOM_SIZE/4)/(ROOM_SIZE/4));
		d3dAddVertex(oControl.vertexFloorRock, _x, _y, _z + L + L*_dcos, make_color_hsv(0, 0, _int*(130-125*_dcos)), 1, _i_tex, _j_tex, 0, 0, -1);
	}
#endregion
#region d3dAddVertexCalcSphere
	/// @func  d3dAddVertexCalcSphere(vertex,xBase,yBase,zBase,lon,phi,theta,color,alpha,itexture,jtexture,n)
	function d3dAddVertexCalcSphere(_vtx,_xBase,_yBase,_zBase,_lon,_phi,_theta,_col,_alp,_i_tex,_j_tex,_n) {
		d3dAddVertex(_vtx,
			_xBase+_lon*dcos(_phi)*dcos(_theta),
			_yBase-_lon*dsin(_phi)*dcos(_theta),
			_zBase+_lon*dsin(_theta),
			_col,_alp,_i_tex,_j_tex,
			+_n*dcos(_phi)*dcos(_theta),
			-_n*dsin(_phi)*dcos(_theta),
			+_n*dsin(_theta)
		);
	}
#endregion
#region matrixBuildExt
	/// @func  matrixBuildExt(x,y,z,lambda,theta,phi,xscale,yscale,zscale)
	function matrixBuildExt(_x,_y,_z,_lambda,_theta,_phi,_xs,_ys,_zs) {
		return matrix_multiply(
			matrix_multiply(
				matrix_multiply(
					matrix_multiply(matrix_build(0,0,0,0,0,0,_xs,_ys,_zs),matrix_build(0,0,0,_lambda,0,0,1,1,1)),
						matrix_build(0,0,0,0,-_theta,0,1,1,1)),
					matrix_build(0,0,0,0,0,_phi,1,1,1)),
			matrix_build(_x,_y,_z,0,0,0,1,1,1));
	}
#endregion
#region d3dAddPipe
	/// @func  d3dAddPipe(vertex,x,y,z,radio_bot,radio_top,altura,outside,extended,increment,color,alphaBase,alphaTop,leftTexture,topTexture,rightTexture,botTexture)
	function d3dAddPipe() {
		var _vtx = argument[0],
			_x = argument[1],
			_y = argument[2],
			_z = argument[3],
			_rb = argument[4],
			_rt = argument[5],
			_alt = argument[6],
			_out = argument[7],
			_ext = argument[8],
			_incr = argument[9],
			_col = argument[10],
			_alpBase = argument[11],
			_alpTop = argument[12],
			_leftt = argument[13],
			_topt = argument[14],
			_rightt = argument[15],
			_bott = argument[16];
		
		var _ini = 360,_fin = 0,_inc = -_incr;
		if (_out) {
			_ini = 0;
			_fin = 360;
			_inc = +_incr;
		}
		
		// El pipe.
		for (var i = _ini; i != _fin; i += _inc) {
			var _itex0 = _leftt+(_rightt-_leftt)*i/360;
			var _itex1 = _leftt+(_rightt-_leftt)*(i+_inc)/360;
			var _xm = _alt*0.1*(!_out and _ext);
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i),		_z+_rb*dsin(i),_col,_alpTop,_itex0,_bott,		0,dcos(i	 ),dsin(i	  ));
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i),		_z+_rt*dsin(i),_col,_alpBase,_itex0,_topt,		0,dcos(i	 ),dsin(i	  ));
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i+_inc),	_z+_rb*dsin(i+_inc),_col,_alpTop,_itex1,_bott,	0,dcos(i+_inc),dsin(i+_inc));
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i+_inc),	_z+_rb*dsin(i+_inc),_col,_alpTop,_itex1,_bott,	0,dcos(i+_inc),dsin(i+_inc));
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i),		_z+_rt*dsin(i),_col,_alpBase,_itex0,_topt,		0,dcos(i	 ),dsin(i	  ));
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i+_inc),	_z+_rt*dsin(i+_inc),_col,_alpBase,_itex1,_topt,	0,dcos(i+_inc),dsin(i+_inc));
		}
	}
#endregion
#region d3dAddSphere
	/// @func  d3dAddSphere(vertex,x,y,z,radius,dirBase,dirTop,outside,steps,color,alpha,leftTexture,topTexture,rightTexture,botTexture)
	function d3dAddSphere(_vtx,_x,_y,_z,_rad,_dirBase,_dirTop,_out,_ste,_col,_alp,_leftt,_topt,_rightt,_bott) {
		// "steps" debe ser divisible de 90
		// Init.
		var _ini = 0,_fin = 360,_inc = 1;
		var _n = _out ? 1 : -1;
		if (!_out) {
			_ini = 360;
			_fin = 0;
			_inc = -1;
		}
		var _s = _ste;
		var _inc = _s*_inc;
		
		for (var i = _dirBase; i < _dirTop; i += _s) {
			for (var j = _ini; j != _fin; j += _inc) {
				var _itex0 = _leftt+(_rightt-_leftt)*j/360;
				var _itex1 = _leftt+(_rightt-_leftt)*(j+_inc)/360;
				var _jtex0 = _topt+(_bott-_topt)*(i+90+_s)/180;
				var _jtex1 = _topt+(_bott-_topt)*(i+90)/180;
				
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j,i,_col,_alp,_itex0,_jtex1,_n);
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j+_inc,i,_col,_alp,_itex1,_jtex1,_n);
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j,i+_s,_col,_alp,_itex0,_jtex0,_n);
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j,i+_s,_col,_alp,_itex0,_jtex0,_n);
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j+_inc,i,_col,_alp,_itex1,_jtex1,_n);
				d3dAddVertexCalcSphere(_vtx,_x,_y,_z,_rad,j+_inc,i+_s,_col,_alp,_itex1,_jtex0,_n);
			}
		}
	}
#endregion
#region d3dAddCube
	/// @func d3dAddCube(vertex,x,y,z,width,height,depth,color,alpha,leftTexture,topTexture,rightTexture,botTexture)
	/*function d3dAddCube(_vtx,_x,_y,_z,_w,_h,_d,_col,_alp,_leftt,_topt,_rightt,_bott) {
		// Left
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
		// Right
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
		// Front
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
		// Back
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
		// Top
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
		// Bot
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott, 1,0,0); //1
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott, 1,0,0); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_topt, 1,0,0); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_topt, 1,0,0); //4
	}*/
#endregion
#region d3dAddQuadraVertex
	/// @func d3dAddQuadraVertex(vertex,color,alpha,x1,y1,z1,it1,jt1,i1,j1,k1,x2,y2,z2,it2,jt2,i2,j2,k2,x3,y3,z3,it3,jt3,i3,j3,k3,x4,y4,z4,it4,jt4,i4,j4,k4)
	function d3dAddQuadraVertex() {		
		d3dAddVertex(	argument[0], argument[3], argument[4], argument[5],
							argument[1], argument[2], argument[6], argument[7], argument[8], argument[9], argument[10]); //1
		d3dAddVertex(	argument[0], argument[11], argument[12], argument[13],
							argument[1], argument[2], argument[14], argument[15], argument[16], argument[17], argument[18]); //2
		d3dAddVertex(	argument[0], argument[19], argument[20], argument[21],
							argument[1], argument[2], argument[22], argument[23], argument[24], argument[25], argument[26]); //3
		d3dAddVertex(	argument[0], argument[19], argument[20], argument[21],
							argument[1], argument[2], argument[22], argument[23], argument[24], argument[25], argument[26]); //3
		d3dAddVertex(	argument[0], argument[11], argument[12], argument[13],
							argument[1], argument[2], argument[14], argument[15], argument[16], argument[17], argument[18]); //2
		d3dAddVertex(	argument[0], argument[27], argument[28], argument[29],
							argument[1], argument[2], argument[30], argument[31], argument[32], argument[33], argument[34]); //4
	}
#endregion
#region d3dAddSolidEnvironment
	/// @func d3dAddSolidEnvironment(i,j,k,x1,y1,z1,i1,j1,x2,y2,z2,i2,j2,x3,y3,z3,i3,j3,x4,y4,z4,i4,j4)
	function d3dAddSolidEnvironment() {
		d3dAddSolidVertex(	argument[3]+argument[0]*L, argument[4]+argument[1]*L, argument[5]-argument[2]*L,
							argument[6], argument[7]); //1
		d3dAddSolidVertex(	argument[8]+argument[0]*L, argument[9]+argument[1]*L, argument[10]-argument[2]*L,
							argument[11], argument[12]); //2
		d3dAddSolidVertex(	argument[13]+argument[0]*L, argument[14]+argument[1]*L, argument[15]-argument[2]*L,
							argument[16], argument[17]); //3
		d3dAddSolidVertex(	argument[13]+argument[0]*L, argument[14]+argument[1]*L, argument[15]-argument[2]*L,
							argument[16], argument[17]); //3
		d3dAddSolidVertex(	argument[8]+argument[0]*L, argument[9]+argument[1]*L, argument[10]-argument[2]*L,
							argument[11], argument[12]); //2
		d3dAddSolidVertex(	argument[18]+argument[0]*L, argument[19]+argument[1]*L, argument[20]-argument[2]*L,
							argument[21], argument[22]); //4
	}
#endregion
#region d3dAddSolidFloor
	/// @func d3dAddSolidFloor(i,j,k,x1,y1,z1,i1,j1,x2,y2,z2,i2,j2,x3,y3,z3,i3,j3,x4,y4,z4,i4,j4)
	function d3dAddSolidFloor() {
		d3dAddFloorVertex(	argument[3]+argument[0]*L, argument[4]+argument[1]*L, argument[5]-argument[2]*L,
							argument[6], argument[7]); //1
		d3dAddFloorVertex(	argument[8]+argument[0]*L, argument[9]+argument[1]*L, argument[10]-argument[2]*L,
							argument[11], argument[12]); //2
		d3dAddFloorVertex(	argument[13]+argument[0]*L, argument[14]+argument[1]*L, argument[15]-argument[2]*L,
							argument[16], argument[17]); //3
		d3dAddFloorVertex(	argument[13]+argument[0]*L, argument[14]+argument[1]*L, argument[15]-argument[2]*L,
							argument[16], argument[17]); //3
		d3dAddFloorVertex(	argument[8]+argument[0]*L, argument[9]+argument[1]*L, argument[10]-argument[2]*L,
							argument[11], argument[12]); //2
		d3dAddFloorVertex(	argument[18]+argument[0]*L, argument[19]+argument[1]*L, argument[20]-argument[2]*L,
							argument[21], argument[22]); //4
	}
#endregion
#region d3dAddTrioVertex
	/// @func d3dAddTrioVertex(vertex,color,alpha,x1,y1,z1,i1,j1,nx1,ny1,nz1,x2,y2,z2,i2,j2,nx2,ny2,nz2,x3,y3,z3,i3,j4,nx3,ny3,nz3)
	function d3dAddTrioVertex() {
		d3dAddVertex(argument[0],argument[3],argument[4],argument[5],argument[1],argument[2],argument[6],argument[7], argument[8],argument[9],argument[10]); //1
		d3dAddVertex(argument[0],argument[11],argument[12],argument[13],argument[1],argument[2],argument[14],argument[15], argument[16],argument[17],argument[18]); //2
		d3dAddVertex(argument[0],argument[19],argument[20],argument[21],argument[1],argument[2],argument[22],argument[23], argument[24],argument[25],argument[26]); //3
	}
#endregion