#!/usr/bin/env bash
#		Unimak map
        awk '{ print $1, $2, 0.15+$4*0.08 }' pre-chignik.txt > pre-chignik.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-oct2022.txt > till-oct2022.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-Jan2023.txt > till-Jan2023.dat
        awk '{ print $1, $2, 0.15+$4*0.08 }' till-Aug2023.txt > till-Aug2023.dat
        awk '{ print $1, $2+1.1, 0.15+$3*0.08 }' mag.txt > mag.dat

gmt begin AV_zoom pdf 

	# GMT set/configuration
	gmt set MAP_FRAME_TYPE plain
        gmt set PS_MEDIA letter

	# Generate base map
        # gmt which -Gu @earth_relief_10m.grd

	gmt psbasemap -JM16 -R-160.5/-157/55.5/57.5 -Xc -Yc -B1 -BNEsw --FONT_ANNOT_PRIMARY=10p,Helvetica --MAP_DEGREE_SYMBOL=degree

	# Plot grid image
	gmt grd2cpt -R-160.5/-157/55.5/57.5 earth_relief_15s.grd -Cetopo1 -Z -L0/3000
	gmt grdimage -R-160.5/-157/55.5/57.5 earth_relief_15s.grd -I+a15+ne0.75
 

	# Generate coast line of an area
	gmt pscoast -R-160.5/-157/55.5/57.5 -JM16 -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Helvetica  -W0.1p,gray40 -Lg-157.5/55.9+w50+c-160/56 
	gmt psxy -R-160.5/-157/55.5/57.5 pre-chignik.dat -Sc -Gwhite -W
	gmt psxy -R-160.5/-157/55.5/57.5 till-oct2022.dat -Sc -G255/193/7 -W
	gmt psxy -R-160.5/-157/55.5/57.5 till-Jan2023.dat -Sc -G30/136/229 -W
	gmt psxy -R-160.5/-157/55.5/57.5 till-Aug2023.dat -Sc -G216/27/96 -W
	gmt psxy -R-160.5/-157/55.5/57.5 mag.dat -Sc -Ggray -W
	gmt psxy -R-160.5/-157/55.5/57.5 AVO_station.txt -Ss0.3 -Ggreen -W
	#gmt psxy -R-161/-153/53/58 trench.txt -Sf0.4i/0.08i+r+t -Gblack -W

	# Plot Colorbar
#	gmt psscale -Cdem1 -Dx-10c/-2.0c+w15c/0.5c+h -Bxa1000f+l"Elevation" -By+lm -G0/3000


gmt end 


