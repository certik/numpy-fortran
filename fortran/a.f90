program a
use types, only: dp
use compute, only: init, register_func, run, eq

type(eq) :: d

call init(d)
call register_func(d, derivs)
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10)
print *
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10)

contains

function derivs(x) result(y)
use types, only: dp
real(dp), intent(in) :: x(2)
real(dp) :: y(2)
integer :: eq_type
eq_type = 1
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
