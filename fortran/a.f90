program a
use types, only: dp
use compute, only: init, register_func, run, eq

type(eq) :: d
character(len=1), allocatable :: data(:)
integer :: l

call init(d)
call register_func(d, derivs)
l = size(transfer(1, data))
allocate(data(l))
data = transfer(1, data)
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10, data)
print *
deallocate(data)
l = size(transfer(2, data))
allocate(data(l))
data = transfer(2, data)
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10, data)

contains

function derivs(x, data) result(y)
use types, only: dp
real(dp), intent(in) :: x(2)
character(len=1), intent(in) :: data(:)
real(dp) :: y(2)
integer :: eq_type
eq_type = transfer(data, eq_type)
if (eq_type == 1) then
    y(1) = -x(2)
    y(2) = x(1)
else if (eq_type == 2) then
    y(1) = x(2)
    y(2) = x(1)
else
    print *, "Not Implemented"
    stop 1
end if
end function

end program
