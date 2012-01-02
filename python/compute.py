def init():
    return {}

def register(d, func, data):
    d["func"] = func
    d["data"] = data

def run(d, in_conditions, dt, nsteps):
    func = d["func"]
    data = d["data"]
    x, y = in_conditions
    t = 0
    for n in range(nsteps):
        dx, dy = func([x, y], data)
        print x, y
        x += dx * dt
        y += dy * dt
        t += dt
