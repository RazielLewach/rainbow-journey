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
#region d3dAddQuadraVertexArray
	/// @func d3dAddQuadraVertexArray(vertex,color,alpha,v1,v2,v3,v4)
	function d3dAddQuadraVertexArray() {
		var _v1 = argument[3];
		var _v2 = argument[4];
		var _v3 = argument[5];
		var _v4 = argument[6];
		var _vCol = argument[1];
		d3dAddVertex(argument[0],_v1[0],_v1[1],_v1[2],_vCol[0],argument[2],_v1[3],_v1[4],_v1[5],_v1[6],_v1[7]); //1
		d3dAddVertex(argument[0],_v2[0],_v2[1],_v2[2],_vCol[1],argument[2],_v2[3],_v2[4],_v2[5],_v2[6],_v2[7]); //2
		d3dAddVertex(argument[0],_v3[0],_v3[1],_v3[2],_vCol[2],argument[2],_v3[3],_v3[4],_v3[5],_v3[6],_v3[7]); //3
		d3dAddVertex(argument[0],_v3[0],_v3[1],_v3[2],_vCol[2],argument[2],_v3[3],_v3[4],_v3[5],_v3[6],_v3[7]); //3
		d3dAddVertex(argument[0],_v2[0],_v2[1],_v2[2],_vCol[1],argument[2],_v2[3],_v2[4],_v2[5],_v2[6],_v2[7]); //2
		d3dAddVertex(argument[0],_v4[0],_v4[1],_v4[2],_vCol[3],argument[2],_v4[3],_v4[4],_v4[5],_v4[6],_v4[7]); //3
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