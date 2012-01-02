from compute import register, run, init

def derivs(coord, data):
    x, y = coord
    if data == "eq1":
        return -y, x
    elif data == "eq2":
        return y, x
    else:
        raise NotImplementedError()

d = init()
data = "eq1"
register(d, derivs)
run(d, [0, 1], 0.1, 10, "eq1")
print
run(d, [0, 1], 0.1, 10, "eq2")
