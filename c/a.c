#include <stdio.h>
#include <stdlib.h>

#include "compute.h"

typedef struct {
    // Material coefficients:
    double a11, a12, a21, a22;
    // There can be a lot of variables and big arrays here, this needs
    // to be passed around by reference.
} my_data;

void derivs(double x, double y, double *dx, double *dy, void *data)
{
    my_data *d = data;
    *dx = d->a11 * x + d->a12 * y;
    *dy = d->a21 * x + d->a22 * y;
}

void print_material_parameters(eq d)
{
    // Access the context:
    my_data *ctx;
    get_context(d, &ctx);
    printf("Material parameters: %f %f %f %f\n", ctx->a11, ctx->a12,
            ctx->a21, ctx->a22);
}

int main()
{
    my_data data1;
    data1.a11 = 0;
    data1.a12 = -1;
    data1.a21 = 1;
    data1.a22 = 0;

    my_data data2;
    data2.a11 = 0;
    data2.a12 = 1;
    data2.a21 = 1;
    data2.a22 = 0;

    eq d;
    init(&d);
    register_func(d, derivs, &data1);
    run(d, 0, 1, 0.1, 10);
    print_material_parameters(d);

    printf("\n");
    register_func(d, derivs, &data2);
    run(d, 0, 1, 0.1, 10);
    print_material_parameters(d);
    destroy(&d);
    return 0;
}
