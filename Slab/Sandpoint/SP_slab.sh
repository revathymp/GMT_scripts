#Fresh 2021 December Aleutian slab -165/-150/53/59, Mu= 0.4

grd2xyz alu_slab2_dep_12.13.21.grd > SPAlu.xyz
awk {'print $1-180,$2,$3'} SPAlu.xyz > SPAlu-1.xyz
awk '$3 != "NaN"' FS=' ' k=3 SPAlu-1.xyz | sort -n -k3,3 > SPAlu-2.xyz
awk '$3 > -65 {printf "%.6f %.6f %.6f\n", $1, $2, ($3*(-1))}' FS=' ' k=3 SPAlu-2.xyz > SPAlu-3.xyz
awk 'NR > 3 {printf "%.6f %.6f %.6f %.6f\n", (($1/63.60432533)+(-159.626)),(($2/111.19)+54.602),$3, $4}' Mu_0-4/dcff*.cou > dcff-0-4.txt
awk 'NR > 3 {printf "%.6f %.6f %.6f %.6f\n", (($1/63.60432533)+(-159.626)),(($2/111.19)+54.602),$3, $4}' Mu_0-1/dcff*.cou > dcff-0-1.txt
#*******************************************
#  run "python slab_coulomb.py"
#**************results*********************
#dcff-0-1.txt
#24541 points found
#min dist: 0.0002020000000015898
#max dist: 8.962759064871936
#dcff-0-4.txt
#24541 points found
#min dist: 0.0002020000000015898
#max dist: 8.962759064871936
#******************************************
paste SPxyc-04.txt SPinter_xyz-04.txt > SPxyc_xyz-04.txt
paste SPxyc-01.txt SPinter_xyz-01.txt > SPxyc_xyz-01.txt

#Fresh 2021 Aleutian slab -165/-150/53/59, Mu= 0.4




awk 'NR > 3 {printf "%.6f %.6f %.6f %.6f\n", (($1/63.60432533)+(-157.841)),(($2/111.19)+55.325),$3, $4}' 26km.txt > C26km.txt
awk '{print $4, $5, $6, $3}' xyc_xyz.txt > coulomb.txt
awk '{print $4, $5, $6, $3}' xyc_xyz.txt | sort -n -k4,4  > coulomb.txt


