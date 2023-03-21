#region setArrD3dOpciones
	/// @func  setArrD3dOpciones(x,y,z,prephi,lambda,theta,phi,xscale,yscale,zscale)
	function setArrD3dOpciones(_x,_y,_z,_prephi,_lambda,_theta,_phi,_xs,_ys,_zs) {		
		oControl.matTransformacion = matrix_multiply(
			matrix_multiply(
				matrix_multiply(
					matrix_multiply(
						matrix_multiply(matrix_build(0,0,0,0,0,0,_xs,_ys,_zs),
										matrix_build(0,0,0,0,0,_prephi,1,1,1)
										),
										matrix_build(0,0,0,_lambda,0,0,1,1,1)
					),
				matrix_build(0,0,0,0,-_theta,0,1,1,1)),
				matrix_build(0,0,0,0,0,_phi,1,1,1)),
			matrix_build(_x,_y,_z,0,0,0,1,1,1));
	}
#endregion
#region d3dAddVertex
	/// @func  d3dAddVertex(vertex,x,y,z,color,alpha,itexture,jtexture)
	function d3dAddVertex(_vtx,_x,_y,_z,_col,_alp,_i_tex,_j_tex) {
		var _pos = matrix_transform_vertex(oControl.matTransformacion,_x,_y,_z);
		
		// Defino el vértice.
		vertex_position_3d(_vtx,_pos[0],_pos[1],_pos[2]);
	    vertex_colour(_vtx,_col,_alp);
	    vertex_texcoord(_vtx,_i_tex,_j_tex);
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
	/// @func  d3dAddPipe(vertex,x,y,z,radio_bot,radio_top,altura,outside,extended,increment,color,alpha,leftTexture,topTexture,rightTexture,botTexture,OPCclosed,OPClt,OPCtt,OPCrt,OPCbt)
	function d3dAddPipe(_vtx,_x,_y,_z,_rb,_rt,_alt,_out,_ext,_incr,_col,_alp,_leftt,_topt,_rightt,_bott) {
		var _ini = 360,_fin = 0,_inc = -_incr;
		if (_out) {
			_ini = 0;
			_fin = 360;
			_inc = +_incr;
		}
		var _isClosed = argument_count >= 17 and argument[16];
		
		// El pipe.
		for (var i = _ini+45*_isClosed; i != _fin+45*_isClosed; i += _inc) {
			var _itex0 = _leftt+(_rightt-_leftt)*i/360;
			var _itex1 = _leftt+(_rightt-_leftt)*(i+_inc)/360;
			var _xm = _alt*0.1*(!_out and _ext);
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i),_z+_rb*dsin(i),_col,_alp,_itex0,_bott);
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i),_z+_rt*dsin(i),_col,_alp,_itex0,_topt);
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i+_inc),_z+_rb*dsin(i+_inc),_col,_alp,_itex1,_bott);
			d3dAddVertex(_vtx,_x-_xm		,_y+_rb*dcos(i+_inc),_z+_rb*dsin(i+_inc),_col,_alp,_itex1,_bott);
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i),_z+_rt*dsin(i),_col,_alp,_itex0,_topt);
			d3dAddVertex(_vtx,_x+_xm+_alt	,_y+_rt*dcos(i+_inc),_z+_rt*dsin(i+_inc),_col,_alp,_itex1,_topt);
		}
		
		// El closed.
		if (_isClosed) {
			d3dAddPlane(_vtx,_x,_y,_z,_rb*1.42,_rb*1.42,_col,_alp,argument[17],argument[18],argument[19],argument[20]);
			d3dAddPlane(_vtx,_x+_alt,_y,_z,-_rt*1.42,_rt*1.42,_col,_alp,argument[17],argument[18],argument[19],argument[20]);
		}
	}
#endregion
#region d3dAddSphere
	/// @func  d3dAddSphere(vertex,x,y,z,radius,dirBase,dirTop,outside,steps,color,alpha,leftTexture,topTexture,rightTexture,botTexture)
	function d3dAddSphere(_vtx,_x,_y,_z,_rad,_dirBase,_dirTop,_out,_ste,_col,_alp,_leftt,_topt,_rightt,_bott) {
		// "steps" debe ser divisible de 90
		var _ini = 0,_fin = 360,_inc = 1;
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
				
				// Triángulos.
				d3dAddVertex(_vtx,_x+_rad*dcos(j	   )*dcos(i	  ),_y-_rad*dsin(j     )*dcos(i   ),_z+_rad*dsin(i   ),_col,_alp,_itex0,_jtex1);
				d3dAddVertex(_vtx,_x+_rad*dcos(j+_inc)*dcos(i   ),_y-_rad*dsin(j+_inc)*dcos(i   ),_z+_rad*dsin(i   ),_col,_alp,_itex1,_jtex1);
				d3dAddVertex(_vtx,_x+_rad*dcos(j	   )*dcos(i+_s),_y-_rad*dsin(j     )*dcos(i+_s),_z+_rad*dsin(i+_s),_col,_alp,_itex0,_jtex0);
				d3dAddVertex(_vtx,_x+_rad*dcos(j	   )*dcos(i+_s),_y-_rad*dsin(j     )*dcos(i+_s),_z+_rad*dsin(i+_s),_col,_alp,_itex0,_jtex0);
				d3dAddVertex(_vtx,_x+_rad*dcos(j+_inc)*dcos(i   ),_y-_rad*dsin(j+_inc)*dcos(i   ),_z+_rad*dsin(i   ),_col,_alp,_itex1,_jtex1);
				d3dAddVertex(_vtx,_x+_rad*dcos(j+_inc)*dcos(i+_s),_y-_rad*dsin(j+_inc)*dcos(i+_s),_z+_rad*dsin(i+_s),_col,_alp,_itex1,_jtex0);
			}
		}
	}
#endregion
#region d3dAddPlane
	/// @func  d3dAddPlane(vertex,x,y,z,width,height,color,alpha,leftTexture,topTexture,rightTexture,botTexture)
	function d3dAddPlane(_vtx,_x,_y,_z,_w,_h,_col,_alp,_leftt,_topt,_rightt,_bott) {
		var _clb, _clt, _crb, _crt;
		if (is_array(_col))
		{
			_clb = _col[0];
			_clt = _col[1];
			_crb = _col[2];
			_crt = _col[3];
		}
		else
		{
			_clb = _col;
			_clt = _col;
			_crb = _col;
			_crt = _col;
		}
		d3dAddVertex(_vtx,_x,_y-_w/2,_z+_h/2,_clb,_alp,_leftt,_bott);
		d3dAddVertex(_vtx,_x,_y-_w/2,_z-_h/2,_clt,_alp,_leftt,_topt);
		d3dAddVertex(_vtx,_x,_y+_w/2,_z+_h/2,_crb,_alp,_rightt,_bott);
		d3dAddVertex(_vtx,_x,_y+_w/2,_z+_h/2,_crb,_alp,_rightt,_bott);
		d3dAddVertex(_vtx,_x,_y-_w/2,_z-_h/2,_clt,_alp,_leftt,_topt);
		d3dAddVertex(_vtx,_x,_y+_w/2,_z-_h/2,_crt,_alp,_rightt,_topt);
	}
#endregion
#region d3dAddCube
	/// @func d3dAddCube(vertex,x,y,z,width,height,depth,color,alpha,leftTexture,topTexture,rightTexture,botTexture)
	function d3dAddCube(_vtx,_x,_y,_z,_w,_h,_d,_col,_alp,_leftt,_topt,_rightt,_bott) {
		// Left
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_topt); //4
		// Right
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt); //4
		// Front
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_topt); //4
		// Back
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt); //4
		// Top
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z-_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z-_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z-_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z-_d/2,_col,_alp,_rightt,_topt); //4
		// Bot
		d3dAddVertex(_vtx,_x-_w/2,_y-_h/2,_z+_d/2,_col,_alp,_leftt,_bott); //1
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x+_w/2,_y-_h/2,_z+_d/2,_col,_alp,_rightt,_bott); //3
		d3dAddVertex(_vtx,_x-_w/2,_y+_h/2,_z+_d/2,_col,_alp,_leftt,_topt); //2
		d3dAddVertex(_vtx,_x+_w/2,_y+_h/2,_z+_d/2,_col,_alp,_rightt,_topt); //4
	}
		
#endregion
#region d3dAddQuadraVertex
	/// @func d3dAddQuadraVertex(vertex,color,alpha,x1,y1,z1,i1,j1,x2,y2,z2,i2,j2,x3,y3,z3,i3,j3,x4,y4,z4,i4,j4)
	function d3dAddQuadraVertex() {
		d3dAddVertex(argument[0],argument[3],argument[4],argument[5],argument[1],argument[2],argument[6],argument[7]); //1
		d3dAddVertex(argument[0],argument[8],argument[9],argument[10],argument[1],argument[2],argument[11],argument[12]); //2
		d3dAddVertex(argument[0],argument[13],argument[14],argument[15],argument[1],argument[2],argument[16],argument[17]); //3
		d3dAddVertex(argument[0],argument[13],argument[14],argument[15],argument[1],argument[2],argument[16],argument[17]); //3
		d3dAddVertex(argument[0],argument[8],argument[9],argument[10],argument[1],argument[2],argument[11],argument[12]); //2
		d3dAddVertex(argument[0],argument[18],argument[19],argument[20],argument[1],argument[2],argument[21],argument[22]); //4
	}
#endregion
#region d3dAddQuadraVertexArray
	/// @func d3dAddQuadraVertexArray(vertex,color,alpha,v1,v2,v3,v4)
	function d3dAddQuadraVertexArray() {
		var _v1 = argument[3];
		var _v2 = argument[4];
		var _v3 = argument[5];
		var _v4 = argument[6];
		d3dAddVertex(argument[0],_v1[0],_v1[1],_v1[2],argument[1],argument[2],_v1[3],_v1[4]); //1
		d3dAddVertex(argument[0],_v2[0],_v2[1],_v2[2],argument[1],argument[2],_v2[3],_v2[4]); //2
		d3dAddVertex(argument[0],_v3[0],_v3[1],_v3[2],argument[1],argument[2],_v3[3],_v3[4]); //3
		d3dAddVertex(argument[0],_v3[0],_v3[1],_v3[2],argument[1],argument[2],_v3[3],_v3[4]); //3
		d3dAddVertex(argument[0],_v2[0],_v2[1],_v2[2],argument[1],argument[2],_v2[3],_v2[4]); //2
		d3dAddVertex(argument[0],_v4[0],_v4[1],_v4[2],argument[1],argument[2],_v4[3],_v4[4]); //3
	}
#endregion
#region d3dAddTrioVertex
	/// @func d3dAddTrioVertex(vertex,color,alpha,x1,y1,z1,i1,j1,x2,y2,z2,i2,j2,x3,y3,z3,i3)
	function d3dAddTrioVertex() {
		d3dAddVertex(argument[0],argument[3],argument[4],argument[5],argument[1],argument[2],argument[6],argument[7]); //1
		d3dAddVertex(argument[0],argument[8],argument[9],argument[10],argument[1],argument[2],argument[11],argument[12]); //2
		d3dAddVertex(argument[0],argument[13],argument[14],argument[15],argument[1],argument[2],argument[16],argument[17]); //3
	}
#endregion