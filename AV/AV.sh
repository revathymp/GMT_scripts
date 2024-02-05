#!/usr/bin/env bash
#		Unimak map
        awk '{ print $1, $2, 0.15+$4*0.08 }' pre-chignik.txt > pre-chignik.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-oct2022.txt > till-oct2022.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-Jan2023.txt > till-Jan2023.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-Aug2023.txt > till-Aug2023.dat
        awk '{ print $1, $2, 0.15+$3*0.08 }' mag.txt > mag.dat

gmt begin AV pdf 

	# GMT set/configuration
	gmt set MAP_FRAME_TYPE plain
        gmt set PS_MEDIA letter

	# Generate base map
        # gmt which -Gu @earth_relief_10m.grd

	gmt psbasemap -JM16 -R-161/-153/53/58 -Xc -Yc -B1 -BNWse --FONT_ANNOT_PRIMARY=10p,Helvetica --MAP_DEGREE_SYMBOL=degree

	# Plot grid image
	gmt grd2cpt -R-161/-153/53/58 @earth_relief_01m.grd -Cetopo1 -Z -L0/3000
	gmt grdimage -R-161/-153/53/58 @earth_relief_01m.grd -I+a15+ne0.75
 

	# Generate coast line of an area
	gmt pscoast -R-161/-153/53/58 -JM16 -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Helvetica  -W0.1p,gray40 -Lg-154/54.7+w100+c-160/54,white 
	gmt psxy -R-161/-153/53/58 pre-chignik.dat -Sc -Gwhite -W
	gmt psxy -R-161/-153/53/58 till-oct2022.dat -Sc -Gwhite -W
	gmt psxy -R-161/-153/53/58 till-Jan2023.dat -Sc -Gwhite -W
	gmt psxy -R-161/-153/53/58 till-Aug2023.dat -Sc -Gwhite -W
	gmt psxy -R-161/-153/53/58 mag.dat -Sc -Ggray -W
	gmt psxy -R-161/-153/53/58 trench.txt -Sf0.4i/0.08i+r+t -Gblack -W
	# Plot square box as area sign
	echo -160.5 55.5 > box2.dat
	echo -157 55.5 >> box2.dat
	echo -157 57.5 >> box2.dat
	echo -160.5 57.5 >> box2.dat
	echo -160.5 55.5 >> box2.dat
	gmt psxy -R-161/-153/53/58 -JM16 -W2,white,dashed box2.dat 

 
	# Plot Inset Map
	gmt pscoast -R-170/-140/50/65 -JM5 -N1/0.1p -X11.45 -Y-0.25 -B5 -BSEnw --FONT_ANNOT_PRIMARY=6p,Helvetica -W0.1p,gray40 --MAP_DEGREE_SYMBOL=degree -Gdarkolivegreen -S255/255/255 
	gmt psxy -R-170/-140/50/65 trench.txt -Sf0.2i/0.04i+r+t -Gblack -W
 
		# Plot square box as area sign
		echo -161 53 > box1.dat
		echo -153 53 >> box1.dat
		echo -153 58 >> box1.dat
		echo -161 58 >> box1.dat
		echo -161 53 >> box1.dat
		gmt psxy -R-170/-140/50/65 -JM5 -W0.8,red box1.dat 


 
	# Plot Colorbar
#	gmt psscale -Cdem1 -Dx-10c/-2.0c+w15c/0.5c+h -Bxa1000f+l"Elevation" -By+lm -G0/3000


gmt end 


