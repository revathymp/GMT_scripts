#!/usr/bin/env bash
#		Unimak map


gmt begin Unimak pdf 
	# GMT set/configuration
	gmt set MAP_FRAME_TYPE plain

	# Generate base map
	gmt psbasemap -JM16 -R-165/-163/54.3/55.1 -Xc -Yc -B0.5 -BNEsw --FONT_ANNOT_PRIMARY=10p,Helvetica --MAP_DEGREE_SYMBOL=degree

	# Plot grid image
	gmt grd2cpt -R-165/-163/54.3/55.1 dem.grd -Cgray -Z -L0/3000
	gmt grdimage -R-165/-163/54.3/55.1 dem.grd -I+a15+ne0.75
 

	# Generate coast line of an area
	gmt pscoast -R-165/-163/54.3/55.1 -JM16 -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Helvetica -Swhite -W0.1p,gray40 -Lg-164.7/55+w20+c-164/54.7 
#	gmt psxy -R-165/-163/54.3/55.1 trench.txt -Sf0.8i/0.1i+r+t -Gblack -W
 
	# Plot a multiple symbol
	gmt plot U_cont_GPS.txt -R-165/-163/54.3/55.1 -JM16 -Ss0.15i -G30/136/229 -Wthinnest
	gmt plot U_camp_GPS.txt -R-165/-163/54.3/55.1 -JM16 -St0.15i -G216/27/96 -Wthinnest
        gmt pstext U_cont_GPS.txt -F+f7,Helvetica,30/136/229+jRB -D-0.06i/0i -Gwhite -Wfaint
        gmt pstext U_camp_GPS.txt -F+f7,Helvetica,216/27/96+jLT -D-0.06i/0i -Gwhite -Wfaint
 
	# Plot Inset Map
	gmt pscoast -R-170/-140/50/65 -JM4 -N1/0.1p -X11.65 -Y0.55 -B10 -BWSne --FONT_ANNOT_PRIMARY=6p,Helvetica -W0.1p,gray40 --MAP_DEGREE_SYMBOL=degree -Ggrey -S255/255/255 
	gmt psxy -R-170/-140/50/65 trench.txt -Sf0.2i/0.04i+r+t -Gblack -W
 
		# Plot square box as area sign
		echo -165 54.3 > box1.dat
		echo -163 54.3 >> box1.dat
		echo -163 55.1 >> box1.dat
		echo -165 55.1 >> box1.dat
		echo -165 54.3 >> box1.dat
		gmt psxy -R-170/-140/50/65 -JM4 -W0.8,red box1.dat 
 
	# Plot Colorbar
#	gmt psscale -Cdem1 -Dx-10c/-2.0c+w15c/0.5c+h -Bxa1000f+l"Elevation" -By+lm -G0/3000


gmt end 

