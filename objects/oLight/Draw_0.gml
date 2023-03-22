#region Define la luz.
	draw_light_enable(indLight,true);
	draw_light_define_point(indLight,x,y,z,lonLight,colLight);
	
	draw_circle_color(x,y,lonLight,c_white,c_white,false);
#endregion