module compute
use types, only: dp
implicit none
private
public init, register_func, run, eq

abstract interface
    function derivs(x) result(y)
    use types, only: dp
    real(dp), intent(in) :: x(2)
    real(dp) :: y(2)
    end function
end interface

type eq
    integer :: i
    procedure(derivs), nopass, pointer :: func
end type

contains

subroutine init(d)
type(eq), intent(inout) :: d
d%func => NULL()
end subroutine

subroutine register_func(d, func)
type(eq), intent(inout) :: d
procedure(derivs) :: func
d%func => func
end subroutine

subroutine run(d, x0, dt, n_steps)
type(eq), intent(in) :: d
real(dp), intent(in) :: x0(2), dt
integer, intent(in) :: n_steps

real(dp) :: x(2), dx(2), t
integer :: i
if (.not. associated(d%func)) then
    print *, "d%func is not associated"
end if
x = x0
t = 0
do i = 1, n_steps
    dx = d%func(x)
    print "(f10.6, f10.6)", x
    x = x + dx * dt
    t = t + dt
end do
end subroutine

end module
