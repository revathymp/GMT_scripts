#!/usr/bin/env bash
#		SNR map

gmt begin ChsnrHT pdf,png
        gmt set MAP_FRAME_TYPE   PLAIN
        awk {'print $2,$3,$7,$1'} sigSNR.txt > ChlogH.txt
        awk {'print $2,$3,$8,$1'} sigSNR.txt > ChmlogH.txt
        awk {'print $2,$3,$11,$1'} sigSNR.txt > ChlogT.txt
        awk {'print $2,$3,$12,$1'} sigSNR.txt > ChmlogT.txt
#        awk {'print $2,$3,"7,4","RM",$1'} sigSNR.txt > label.txt
	gmt subplot begin 2x2 -Fs11c/0 -M0.1c -JM11c -R-99/-90/12/21 -X1.5i -Y1.0i -B4 -BWSen
		gmt subplot set 0,0 -Ce1.1i 
		gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
		gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75 
                gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-91/20+w200+c-94/15
                gmt plot ChlogH.txt -St0.1i -CSNR0.cpt -Wthinnest -B4 -BWSen+t"logH for 2017 Mw 8.2 Chiapas"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
                gmt plot Chiapas.txt -Sa0.2i -Gblack -W0.5,red
                gmt pstext label.txt -F+f+j -D-0.06i/0i -Gwhite -Wfaint
                gmt colorbar -DJRM+o1.5c/0+w2i/0.2c -CSNR0.cpt -I --FONT_ANNOT_PRIMARY=12p -Bx2f1 -By+lSNR,db

		gmt subplot set 0,1 -Ce1.1i
		gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
		gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75
                gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-91/20+w200+c-94/15
                gmt plot ChlogT.txt -St0.1i -CSNR0.cpt -Wthinnest -B4 -BWSen+t"logT for 2017 Mw 8.2 Chiapas"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
                gmt pstext label.txt -F+f+j -D-0.06i/0i -Gwhite -Wfaint
                gmt plot Chiapas.txt -Sa0.2i -Gblack -W0.5,red

                gmt subplot set 1,0 -Ce1.1i 
                gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
                gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75
                gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-91/20+w200+c-94/15
                gmt plot ChmlogH.txt -St0.1i -CSNR.cpt -Wthinnest -B4 -BWSen+t"mlogH for 2017 Mw 8.2 Chiapas"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
                gmt plot Chiapas.txt -Sa0.2i -Gblack -W0.5,red
                gmt pstext label.txt -F+f+j -D-0.06i/0i -Gwhite -Wfaint    
                gmt colorbar -DJRM+o1.5c/0+w2i/0.2c -CSNR.cpt -I --FONT_ANNOT_PRIMARY=12p -Bx2f1 -By+lSNR,db

                gmt subplot set 1,1 -Ce1.1i
                gmt grd2cpt @earth_relief_01m.grd -Cgray -Z
                gmt grdimage @earth_relief_01m.grd -I+a15+ne0.75
                gmt pscoast -N1/0.1p --FONT_ANNOT_PRIMARY=10p,Times-Roman -W0.1p,gray40 -Lg-91/20+w200+c-94/15
                gmt plot ChmlogT.txt -St0.1i -CSNR.cpt -Wthinnest -B4 -BWSen+t"mlogT for 2017 Mw 8.2 Chiapas"\
                  --FONT_TITLE=20p,Times-Roman --MAP_TITLE_OFFSET=0c --MAP_DEGREE_SYMBOL=degree
                gmt pstext label.txt -F+f+j -D-0.06i/0i -Gwhite -Wfaint
                gmt plot Chiapas.txt -Sa0.2i -Gblack -W0.5,red
	gmt subplot end
gmt end show
