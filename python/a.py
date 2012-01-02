from compute import register, run, init

def derivs(coord, data):
    x, y = coord
    return -y, x

d = init()
data = "eq1"
register(d, derivs, data)
run(d, [0, 1], 0.1, 10)
