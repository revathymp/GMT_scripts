#!/usr/bin/env bash
#	Coulomb Slab map

awk {'print $1,$2,$3,$4,$5,$6'} FS=',' F521xyc_xyz-04.txt > F521tmp-04.txt
awk {'print $1,$2,$3'} F521tmp-04.txt > F521slab-04.txt
awk {'print $1,$2,$3,$4,$5,$6'} FS=',' F521xyc_xyz-01.txt > F521tmp-01.txt
awk {'print $1,$2,$3'} F521tmp-01.txt > F521slab-01.txt

#awk {'print $1,$2,$4'} coulomb.txt > slab.txt
awk {'print $1,$2,$3,$4,$5,$6'} FS=',' 21xyc_xyz-04.txt > 21tmp-04.txt
awk {'print $1,$2,$3'} 21tmp-04.txt > 21slab-04.txt
awk {'print $1,$2,$3,$4,$5,$6'} FS=',' 21xyc_xyz-01.txt > 21tmp-01.txt
awk {'print $1,$2,$3'} 21tmp-01.txt > 21slab-01.txt
#awk {'print $1,$2,$4'} C26km.txt > CC.txt

gmt begin 
	gmt figure 21IntSlab-04 pdf     
	gmt set MAP_FRAME_TYPE   PLAIN    
	gmt basemap -JM11c -R-161/-150/53/59 -B2 -BWSen+t"Coulomb stress change on Aleutian Slab, Mu=0.4"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
	gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
	gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75 
        gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-152/54.5+w200+c-155.5/56
 	gmt blockmean F521slab-04.txt -R-161/-150/53/59 -I0.0298/0.03 > 21tmpCoul-04.beam
  	gmt surface 21tmpCoul-04.beam -G21CoulGrid-04.grd -I0.0298/0.03 -R-161/-150/53/59
	gmt psmask F521slab-04.txt -R-161/-150/53/59 -I0.119346/0.12 -JM11c -V
	gmt grdimage 21CoulGrid-04.grd -R-161/-150/53/59 -nb+a+t0.5 -JM11c -Cslab.cpt -V
	gmt psmask -C
	gmt psxy trench.txt -R-161/-150/53/59 -JM11c -Sf0.8i/0.1i+r+t -Gblack -W -B2 
	gmt psxy 18contours.txt -R-161/-150/53/59 -JM11c -Sf0.8i/0.1i -Gblack -W -B2
        gmt colorbar -DJRM+o0.25c/0+w2i/0.2c -Cslab.cpt -I --FONT_ANNOT_PRIMARY=12p -L  
gmt end

gmt begin 
	gmt figure 21IntSlab-01 pdf     
	gmt set MAP_FRAME_TYPE   PLAIN    
	gmt basemap -JM11c -R-161/-150/53/59 -B2 -BWSen+t"Coulomb stress change on Aleutian Slab, Mu=0.1"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
	gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
	gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75 
        gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-152/54.5+w200+c-155.5/56
 	gmt blockmean F521slab-01.txt -R-161/-150/53/59 -I0.0298/0.03 > 21tmpCoul-01.beam
  	gmt surface 21tmpCoul-01.beam -G21CoulGrid-01.grd -I0.0298/0.03 -R-161/-150/53/59
	gmt psmask F521slab-01.txt -R-161/-150/53/59 -I0.119346/0.12 -JM11c -V
	gmt grdimage 21CoulGrid-01.grd -R-161/-150/53/59 -nb+a+t0.5 -JM11c -Cslab.cpt -V
	gmt psmask -C
	gmt psxy trench.txt -R-161/-150/53/59 -JM11c -Sf0.8i/0.1i+r+t -Gblack -W -B2 
	gmt psxy 18contours.txt -R-161/-150/53/59 -JM11c -Sf0.8i/0.1i -Gblack -W -B2
        gmt colorbar -DJRM+o0.25c/0+w2i/0.2c -Cslab.cpt -I --FONT_ANNOT_PRIMARY=12p -L  
gmt end

# 	gmt grd2xyz CoulGrid.grd -R-161/-150/53/59 > CoulGrid.txt#
#	gmt grdimage CoulGrid.grd -R-161/-150/53/59 -nb+a+t0.5 -JM11c -Cslab.cpt 
#	gmt xyz2grd slab2.xyz -D+xdegree+ydegree+zCoul -Gslab2.grd -R-161/-150/53/59 -I0.059673/0.06 -V
#	gmt grdsample slab2.grd -I0.0298/0.03 -nb+a+t0.5 -V -Gcoulomb.grd
#	-Bxaf+l"CFS" -By+lbar
