#include <stdio.h>
#include <stdlib.h>

#include "compute.h"

void derivs(double x, double y, double *dx, double *dy, void *data)
{
    char *str = data;
    if (str == "eq1") {
        *dx = -y;
        *dy = x;
    } else if (str == "eq2") {
        *dx = y;
        *dy = x;
    } else {
        printf("Not implemented...\n");
        abort();
    }
}

int main()
{
    eq d;
    init(&d);
    register_func(&d, &derivs);
    run(&d, 0, 1, 0.1, 10, "eq1");
    printf("\n");
    run(&d, 0, 1, 0.1, 10, "eq2");
    return 0;
}
