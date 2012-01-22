typedef void (*derivs_pt)(double x, double y, double *dx, double *dy,
        void *data);

typedef struct {
    void *data;
    derivs_pt func;
} eq;

void init(eq *d);
void register_func(eq *d, derivs_pt func, void* data);
void get_context(eq *d, void **data);
void run(eq *d, double x0, double y0, double dt, double n_steps);
