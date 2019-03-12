""" A package containing code for the Ringmind project
.. module:: orboid_xy
   :synopsis: Test code to try Boids in a Cartesian coordinate system.

.. moduleauthor:: Chris Arridge <c.arridge@lancaster.ac.uk>

"""
import numpy as np
import matplotlib.pyplot as pl
import vis

# acceleration functions
ax_grav = lambda _x,_y,_GM: -_GM*_x/(np.sqrt(_x**2 + _y**2)**3.0)
ay_grav = lambda _x,_y,_GM: -_GM*_y/(np.sqrt(_x**2 + _y**2)**3.0)

# length scale (1 Saturn radius) and gravitational parameter (Saturn)
Rp = 60268e3
GM = 3.7931187e16
h_stepsize = 10*60		# seconds

# Basic parameters
n_steps=10000
n_orboids = 1000
vis_dest = 'matplotlib'		# set to 'vis' for the GIF movie renderer
vis_freq = 50				# how of ten is a frame drawn

# What are the minimum and maximum extents in r for initialisation
r_min = 1.5
r_max = 3.0

# Initialise our Orboids.
r_orboid = (np.random.rand(n_orboids)*(r_max-r_min) + r_min)*Rp
phi_orboid = np.random.rand(n_orboids)*2.0*np.pi
x_orboid = r_orboid*np.cos(phi_orboid)
y_orboid = r_orboid*np.sin(phi_orboid)
vx_orboid = np.sqrt(GM/(r_orboid))*np.sin(phi_orboid)
vy_orboid = -np.sqrt(GM/(r_orboid))*np.cos(phi_orboid)
v_orboid = np.zeros((n_steps+1,10))
v_orboid[0,:] = np.sqrt(vx_orboid[0:10]**2+vy_orboid[0:10]**2)

# Setup visualisation.
if vis_dest=='matplotlib':
	fig = pl.Figure()
elif vis_dest=='vis':
	rend = vis.Renderer(2.0*r_max, 2.0*r_max, moonlet_radius=0.0,max_particle_radius=0.01,scale=100)
	rend.start_movie('orboid_rphi_test.gif',fps=20)


for i in range(n_steps):
	# leapfrog integration
	x1_orboid = x_orboid + vx_orboid*h_stepsize + 0.5*ax_grav(x_orboid,y_orboid,GM)*h_stepsize*h_stepsize
	y1_orboid = y_orboid + vy_orboid*h_stepsize + 0.5*ay_grav(x_orboid,y_orboid,GM)*h_stepsize*h_stepsize
	vx_orboid = vx_orboid + 0.5*(ax_grav(x_orboid,y_orboid,GM)+ax_grav(x1_orboid,y1_orboid,GM))*h_stepsize
	vy_orboid = vy_orboid + 0.5*(ay_grav(x_orboid,y_orboid,GM)+ay_grav(x1_orboid,y1_orboid,GM))*h_stepsize
	x_orboid = x1_orboid
	y_orboid = y1_orboid
	v_orboid[i+1,:] = np.sqrt(vx_orboid[0:10]**2+vy_orboid[0:10]**2)

	# Draw a frame
	if i%vis_freq==0:
		print(i)
		if vis_dest=='matplotlib':
			pl.clf()
			pl.plot(x_orboid/Rp, y_orboid/Rp, '.r',markersize=1.0)
			pl.xlim([-r_max,r_max])
			pl.ylim([-r_max,r_max])
			pl.gca().set_aspect('equal')
			pl.title(i)
			pl.draw()
			pl.pause(0.0001)
		elif vis_dest=='vis':
#			rend.render(r_orboid*np.cos(phi_orboid), r_orboid*np.sin(phi_orboid), 0.01, n_orboids)
			rend.update_movie()

if vis_dest=='vis':
	rend.end_movie()

# Check energy conservation
pl.close()
pl.Figure()
pl.subplot(2,1,1)
pl.plot(v_orboid**2)
pl.subplot(2,1,2)
pl.semilogy(v_orboid**2*100/v_orboid[0,:]**2)
pl.show()
