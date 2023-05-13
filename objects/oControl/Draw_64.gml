#region Todo negro al inicio.
	alphaDarkness = max(alphaDarkness-0.001, 0);
	draw_set_alpha(alphaDarkness);
	draw_rectangle_color(0, 0, viewWView(), viewHView(), c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
#endregion
#region Dibuja la pantalla de carga.
	if (iProgressLoad >= 0)
	{
		draw_rectangle_color(0, 0, viewWView(), 100, c_black, c_black, c_black, c_black, false);
		draw_text(50, 30, string(round(100*iProgressLoad/iFinalProgress)) + "% (" + textLoading + ")");
		draw_rectangle_color(80, 50, 80 + (viewWView()-160)*(iProgressLoad/iFinalProgress), 80,
			colorFinalEssence, colorFinalEssence, colorFinalEssence, colorFinalEssence, false);
	}
#endregion