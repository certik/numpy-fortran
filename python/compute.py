def init():
    return {}

def register(d, func):
    d["func"] = func

def run(d, in_conditions, dt, nsteps, data):
    func = d["func"]
    x, y = in_conditions
    t = 0
    for n in range(nsteps):
        dx, dy = func([x, y], data)
        print "%.6f %.6f" % (x, y)
        x += dx * dt
        y += dy * dt
        t += dt
