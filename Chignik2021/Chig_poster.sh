#!/usr/bin/env bash
#		SNR map

gmt begin Chig_poster pdf 

	# GMT set/configuration
	gmt set MAP_FRAME_TYPE plain
 
	# Plot Inset Map
	gmt pscoast -JM20c -R-170/-136/52/72 -Xc -Yc -B4 -BweEN -N1 --FONT_ANNOT_PRIMARY=12p,Helvetica --MAP_DEGREE_SYMBOL=degree -Ggrey -Swhite -Wthinnest,darkgray 
	gmt psxy -R-170/-136/52/72 trench.txt -Sf0.2i/0.04i+r+t -Gblack -W
 
		# Plot square box as area sign
		echo -161 54.5 > box1.dat
		echo -152 54.5 >> box1.dat
		echo -152 58 >> box1.dat
		echo -161 58 >> box1.dat
		echo -161 54.5 >> box1.dat
		gmt psxy -R-170/-136/52/72 -JM20c -W0.8,red box1.dat 
 
gmt end 
