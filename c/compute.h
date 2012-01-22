#ifndef _compute_h
#define _compute_h

typedef void (*derivs_pt)(double x, double y, double *dx, double *dy,
        void *data);

/* Definition of the struct is not visible to user code, changes do not affect ABI */
typedef struct _eq_private *eq;
void init(eq *d);
void register_func(eq d, derivs_pt func, void* data);
void get_context(eq d, void *data);
void run(eq d, double x0, double y0, double dt, double n_steps);
void destroy(eq *d);

#endif
