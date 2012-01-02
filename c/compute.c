#include <stdio.h>

#include "compute.h"

void init(eq d)
{
}

void register_func(eq d, derivs_pt func)
{
    d.func = func;
}

void run(eq d, double x0, double y0, double dt, double n_steps,
        void *data)
{
    double x, y, dx, dy, t;
    int i;
    x = x0;
    y = y0;
    t = 0;
    for (i=0; i < n_steps; i++) {
        d.func(x, y, &dx, &dy, data);
        printf("%f %f\n", x, y);
        x += dx * dt;
        y += dy * dt;
        t += dt;
    }
}
