#region db
function db(_text) {
	if (argument_count == 1) show_debug_message(string(_text));
	else show_debug_message(string(_text) + ": " + string(argument[1]));
}
#endregion
#region aj1
function aj1() {
	return oTrucos.ajustes*1;
}
#endregion
#region ar1
function ar1() {
	return oTrucos.arreglos*1;
}
#endregion
#region ap1
function ap1() {
	return oTrucos.apanyos*1;
}
#endregion
#region ax0
function ax0() {
	if (instance_exists(oTrucos)) {
	    if (argument_count == 1) oTrucos.aux0 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
	    else oTrucos.aux0 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
	}
}
#endregion
#region ax1
function ax1() {
	if (instance_exists(oTrucos)) {
	    if (argument_count == 1) oTrucos.aux1 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
	    else oTrucos.aux1 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
	}
}
#endregion
#region ax2
function ax2() {
	if (instance_exists(oTrucos)) {
	    if (argument_count == 1) oTrucos.aux2 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
	    else oTrucos.aux2 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
	}
}
#endregion
#region ax3
function ax3() {
	if (instance_exists(oTrucos)) {
	    if (argument_count == 1) oTrucos.aux3 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
	    else oTrucos.aux3 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
	}
}
#endregion
#region ax4
	function ax4() {
		if (instance_exists(oTrucos)) {
		    if (argument_count == 1) oTrucos.aux4 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
		    else oTrucos.aux4 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
		}
	}
#endregion
#region ax5
	function ax5() {
		if (instance_exists(oTrucos)) {
		    if (argument_count == 1) oTrucos.aux5 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
		    else oTrucos.aux5 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
		}
	}
#endregion
#region ax6
	function ax6() {
		if (instance_exists(oTrucos)) {
		    if (argument_count == 1) oTrucos.aux6 = string(argument[0]) + string("/") + string(oControl.dirAngular01);
		    else oTrucos.aux6 = string(argument[0]) + ": " + string(argument[1]) + string("/") + string(oControl.dirAngular01);
		}
	}
#endregion


















