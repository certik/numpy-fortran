program a
use types, only: dp
use compute, only: init, register_func, run, eq

type(eq) :: d
integer, allocatable :: data(:)

call init(d)
call register_func(d, derivs)
call type2data(1, data)
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10, data)
print *
call type2data(2, data)
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10, data)

contains

! Here the "type" is just an integer, but we can use any type
subroutine type2data(i, data)
integer, intent(in) :: i
integer, allocatable, intent(out) :: data(:)
integer :: l
l = size(transfer(i, data))
allocate(data(l))
data = transfer(i, data)
end subroutine

subroutine data2type(data, i)
integer, intent(in) :: data(:)
integer, intent(out) :: i
i = transfer(data, i)
end subroutine


function derivs(x, data) result(y)
use types, only: dp
real(dp), intent(in) :: x(2)
integer, intent(in) :: data(:)
real(dp) :: y(2)
integer :: eq_type
call data2type(data, eq_type)
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
