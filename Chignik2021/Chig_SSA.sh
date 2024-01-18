#!/usr/bin/env bash
#		SNR map


awk {'print $2,$1,$3'} sites_GNSS.txt > staGNSS.txt
awk {'print $2,$1,$3'} sites_SM.txt > staSM.txt
gmt begin Chig_SSA pdf 

	# GMT set/configuration
	gmt set MAP_FRAME_TYPE plain

	# Generate base map
	gmt basemap -JM20c -R-170/-148/52/61 -Xc -Yc -B2 -BweEN --FONT_ANNOT_PRIMARY=12p,Helvetica --MAP_DEGREE_SYMBOL=degree

	# Plot grid image
	gmt grd2cpt -R-170/-148/52/61 @earth_relief_01m.grd -Cgray -Z
	gmt grdimage -R-170/-148/52/61 @earth_relief_01m.grd -I+a15+ne0.75 
	
	# Generate coast line of an area
	gmt pscoast -JM20c -R-170/-148/52/61 -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Helvetica -Swhite -W0.1p,gray40 -Lg-165/59+w200+c-157/55 
	gmt grdcontour slip_contour.grd -C1 -Wred -A1
	gmt grdcontour Simeonof_slip.grd -C0.5 -Wblack -A0.5
 
	# Plot a multiple symbol
        gmt plot -JM20c -R-170/-148/52/61 staGNSS.txt -Ss0.2i -G30/136/229 -Wthinnest 
        gmt plot -JM20c -R-170/-148/52/61 staSM.txt -St0.2i -G216/27/96 -Wthinnest 
        gmt plot -JM20c -R-170/-148/52/61 Chignik.txt -Sa0.25i -Gblack -W0.5,red
	gmt psxy -JM20c -R-170/-148/52/61 trench.txt -Sf0.8i/0.1i+r+t -Gblack -W
        gmt pstext -JM20c -R-168/-148/52/61 staGNSS.txt -F+f10,Helvetica,30/136/229+jRB -D-0.06i/0i -Gwhite -Wfaint
        gmt pstext -JM20c -R-170/-148/52/61 staSM.txt -F+f10,Helvetica,216/27/96+jLT -D-0.06i/0i -Gwhite -Wfaint
 
	# Plot Inset Map
	gmt pscoast -R-180/-130/45/65 -JA-155/55/6c -N1/0.1p -X13.9 -Y0.35 -B10 -BWSne --FONT_ANNOT_PRIMARY=6p,Helvetica -W0.1p,gray40 --MAP_DEGREE_SYMBOL=degree -Ggrey -S255/255/255 
#	gmt psxy -R-180/-130/45/65 trench.txt -Sf0.2i/0.04i+r+t -Gblack -W
 
		# Plot square box as area sign
		echo -170 52 > box1.dat
		echo -148 52 >> box1.dat
		echo -148 61 >> box1.dat
		echo -170 61 >> box1.dat
		echo -170 52 >> box1.dat
		gmt psxy -R-180/-130/45/65 -JA-155/55/6c -W0.8,red box1.dat 
 
gmt end 
