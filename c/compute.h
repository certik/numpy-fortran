typedef void (*derivs_pt)(double x, double y, double *dx, double *dy,
        void *data);

typedef struct {
    derivs_pt func;
} eq;

void init(eq d);
void register_func(eq d, derivs_pt func);
void run(eq d, double x0, double y0, double dt, double n_steps,
        void *data);
