#region Draw GUI
	var _text = "";
	_text += "player: x=" + string(oPlayer.x) + ", y=" + string(oPlayer.y) + ", z=" + string(oPlayer.z) + "\n";
	_text += "camera: phi=" + string(oCamera.dirCamPhi) + ", theta=" + string(oCamera.dirCamTheta) + "\n";
	if (aux0 != "NOT-DEFINED") _text += "aux0 = " + string(aux0) + "\n";
	if (aux1 != "NOT-DEFINED") _text += "aux1 = " + string(aux1) + "\n";
	if (aux2 != "NOT-DEFINED") _text += "aux2 = " + string(aux2) + "\n";
	if (aux3 != "NOT-DEFINED") _text += "aux3 = " + string(aux3) + "\n";
	if (aux4 != "NOT-DEFINED") _text += "aux4 = " + string(aux4) + "\n";
	if (aux5 != "NOT-DEFINED") _text += "aux5 = " + string(aux5) + "\n";
	if (aux6 != "NOT-DEFINED") _text += "aux6 = " + string(aux6) + "\n";
	if ajustes != 0 _text += "# ajustes="+string(ajustes);
	if arreglos != 0 _text += "# arreglos="+string(arreglos);
	if apanyos != 0 _text += "# apanyos="+string(apanyos);


	draw_set_font(fBase);
	draw_set_color(c_white);
	draw_set_valign(fa_top);

	draw_text(10,50,_text);

	draw_set_valign(fa_middle);
#endregion