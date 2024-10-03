set table "pic.plot.table"; set format "%.5f"
 f(x,y) = -1*(y+1.25)/sqrt((y+1.25)**2+x**2) + +1*(y-1.25)/sqrt((y-1.25)**2+x**2); set xrange [-3:3]; set yrange [-2.5:2.5]; set view 0,0; set isosample 400,400; set cont base; set cntrparam levels discrete -0.1,-0.4,-0.7,-1.0,-1.3,-1.6,-1.9; unset surface; splot f(x,y) 
