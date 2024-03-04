"""
Interpolate plate interface values from Coulomb 3.0 fomatted stress-change files
"""
import os
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import KDTree

choice = "coulomb"

val_list = ["x", "y", "z", "coulomb"]
interface = np.loadtxt("SPAlu-3.xyz")

fid = f"dcff-0-4.txt"
print(fid)
N=len(fid)-1
for i in range(0,N):
    try:
        values = np.loadtxt(fid, dtype=float)
    except ValueError:
        print ("error" , ValueError , "in line" , i)
xyz = values[:, :3]

    # Query nearest neighbor only for points that fall in the applicable depths
zmin = xyz[:, 2].min()
zmax = xyz[:, 2].max()
idx = np.where((interface[:, 2] > zmin) & (interface[:, 2] < zmax))
inter_xyz = interface[idx]

    # Use SciPy KDTree to find nearest neighbor of coulomb grid given the interface
kdtree = KDTree(xyz)
dist, point = kdtree.query(inter_xyz)
print(f"{len(point)} points found")
print(f"min dist: {dist.min()}")
print(f"max dist: {dist.max()}")

    # Grab the Coulomb values and plot on a 2D plane
c_idx = val_list.index(choice)
xyc = values[:, [0, 1, c_idx]][point]  # Vs
x, y, c = xyz.T
coulomb = x, y, c
a = sorted(xyc, key=lambda xyc_entry: xyc_entry[1])
np.savetxt("SPxyc-04.txt" , a, fmt='%f', delimiter=",")
b = sorted(inter_xyz, key=lambda inter_xyz_entry: inter_xyz_entry[1])
np.savetxt("SPinter_xyz-04.txt" , b, fmt='%f', delimiter=",")
#plt.scatter(x, y, c=c)

#plt.colorbar()
#plt.show()
