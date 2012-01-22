module compute
use types, only: dp
implicit none
private
public init, destroy, register_func, run, eq, get_context

abstract interface
    function derivs(x, data) result(y)
    use types, only: dp
    implicit none
    real(dp), intent(in) :: x(2)
    integer, intent(in) :: data(:)
    real(dp) :: y(2)
    end function
end interface

type eq
    integer, allocatable :: data(:)
    procedure(derivs), nopass, pointer :: func
end type

contains

subroutine init(d)
type(eq), pointer, intent(inout) :: d
allocate(d)
d%func => NULL()
end subroutine

subroutine destroy(d)
type(eq), pointer, intent(inout) :: d
deallocate(d)
end subroutine

subroutine register_func(d, func, data)
type(eq), intent(inout) :: d
procedure(derivs) :: func
integer, intent(in) :: data(:)
d%func => func
if (allocated(d%data)) deallocate(d%data)
allocate(d%data(size(data)))
d%data = data
end subroutine

function get_context(d) result(data)
type(eq), intent(in) :: d
integer :: data(size(d%data))
data = d%data
end function

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
    dx = d%func(x, d%data)
    print "(f10.6, f10.6)", x
    x = x + dx * dt
    t = t + dt
end do
end subroutine

end module
