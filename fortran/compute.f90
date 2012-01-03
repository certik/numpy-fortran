module compute

implicit none
private
public init, register_func, run

abstract interface
    function derivs(x) result(y)
    real(dp), intent(in) :: x(2)
    real(dp) :: y(2)
    end function
end interface

type eq
    integer :: i
    procedure(derivs) :: func
end type

contains

subroutine init(d)
type(eq), intent(inout) :: d
d%func = NULL;
end subroutine

subroutine register_func(d, func)
type(eq), intent(inout) :: d
procedure(derivs), intent(in) :: func
d%func => func;
end subroutine

subroutine (d, x0, dt, n_steps)
type(eq), intent(in) :: d
real(dp), intent(in) :: x0(2), dt
integer, intent(in) :: n_steps

real(dp) :: x(2), dx(2), t
x = x0
t = 0
do i = 1, n_steps
    dx = d%func(x)
    print *, x
    x += dx * dt
    t += dt
end do
end subroutine
