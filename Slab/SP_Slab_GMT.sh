#!/usr/bin/env bash
#	Coulomb Slab map

#awk {'print $1,$2,$4'} coulomb.txt > slab.txt
awk {'print $1,$2,$3,$4,$5,$6'} FS=',' SPxyc_xyz-04.txt > SPtmp-04.txt
awk {'print $1,$2,$3'} SPtmp-04.txt > SPslab-04.txt
awk {'print $1,$2,$3,$4,$5,$6'} FS=',' SPxyc_xyz-01.txt > SPtmp-01.txt
awk {'print $1,$2,$3'} SPtmp-01.txt > SPslab-01.txt
#awk {'print $1,$2,$4'} C26km.txt > CC.txt

gmt begin 
	gmt figure SPIntSlab-04 pdf     
	gmt set MAP_FRAME_TYPE   PLAIN    
	gmt basemap -JM11c -R-163/-155/53/57 -B2 -BWSen+t"Coulomb stress change on Aleutian Slab, Mu=0.4"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
	gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
	gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75 
        gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-157/54.5+w200+c-155.5/56
 	gmt blockmean SPslab-04.txt -R-163/-155/53/57 -I0.0298/0.03 > SPtmpCoul-04.beam
  	gmt surface SPtmpCoul-04.beam -GSPCoulGrid-04.grd -I0.0298/0.03 -R-163/-155/53/57
	gmt psmask SPslab-04.txt -R-163/-155/53/57 -I0.119346/0.12 -JM11c -V
	gmt grdimage SPCoulGrid-04.grd -R-163/-155/53/57 -nb+a+t0.5 -JM11c -Cslab.cpt -V
	gmt psmask -C
	gmt psxy trench.txt -R-163/-155/53/57 -JM11c -Sf0.8i/0.1i+r+t -Gblack -W -B2 
	gmt psxy 18contours.txt -R-163/-155/53/57 -JM11c -Sf0.8i/0.1i -Gblack -W -B2
        gmt colorbar -DJRM+o0.25c/0+w2i/0.2c -Cslab.cpt -I --FONT_ANNOT_PRIMARY=12p -L  
gmt end

gmt begin 
	gmt figure SPIntSlab-01 pdf     
	gmt set MAP_FRAME_TYPE   PLAIN    
	gmt basemap -JM11c -R-163/-155/53/57 -B2 -BWSen+t"Coulomb stress change on Aleutian Slab, Mu=0.1"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
	gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
	gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75 
        gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-157/54.5+w200+c-155.5/56
 	gmt blockmean SPslab-01.txt -R-163/-155/53/57 -I0.0298/0.03 > SPtmpCoul-01.beam
  	gmt surface SPtmpCoul-01.beam -GSPCoulGrid-01.grd -I0.0298/0.03 -R-163/-155/53/57
	gmt psmask SPslab-01.txt -R-163/-155/53/57 -I0.119346/0.12 -JM11c -V
	gmt grdimage SPCoulGrid-01.grd -R-163/-155/53/57 -nb+a+t0.5 -JM11c -Cslab.cpt -V
	gmt psmask -C
	gmt psxy trench.txt -R-163/-155/53/57 -JM11c -Sf0.8i/0.1i+r+t -Gblack -W -B2 
	gmt psxy 18contours.txt -R-163/-155/53/57 -JM11c -Sf0.8i/0.1i -Gblack -W -B2
        gmt colorbar -DJRM+o0.25c/0+w2i/0.2c -Cslab.cpt -I --FONT_ANNOT_PRIMARY=12p -L  
gmt end

# 	gmt grd2xyz CoulGrid.grd -R-163/-155/53/57 > CoulGrid.txt#
#	gmt grdimage CoulGrid.grd -R-163/-155/53/57 -nb+a+t0.5 -JM11c -Cslab.cpt 
#	gmt xyz2grd slab2.xyz -D+xdegree+ydegree+zCoul -Gslab2.grd -R-163/-155/53/57 -I0.059673/0.06 -V
#	gmt grdsample slab2.grd -I0.0298/0.03 -nb+a+t0.5 -V -Gcoulomb.grd
#	-Bxaf+l"CFS" -By+lbar
