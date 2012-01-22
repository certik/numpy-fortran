module my_data_type
! This module exports the data type and conversion routines
! to convert a pointer to untyped data(:)
! It is only used from the main program a.f90
use types, only: dp
implicit none
private
! Only these symbols are available from the main program:
public my_data, type2data, data2type

type my_data
    ! Material coefficients:
    real(dp) :: a11, a12, a21, a22
    ! There can be a lot of variables and big arrays here, this needs
    ! to be passed around by reference.
end type

type my_data_ptr
    type(my_data), pointer :: ptr
end type

contains

function data2type(data) result(d)
integer, intent(in) :: data(:)
type(my_data), pointer :: d
type(my_data_ptr) :: tmp
tmp = transfer(data, tmp)
d => tmp%ptr
end function

pure integer function pointer_length() result(l)
type(my_data_ptr) :: p
integer, allocatable :: data(:)
l = size(transfer(p, data))
end function

function type2data(d) result(data)
type(my_data), intent(in), target :: d
integer :: data(pointer_length())
type(my_data_ptr) :: tmp
tmp%ptr => d
data = transfer(tmp, data)
end function

end module



program a
use types, only: dp
use compute, only: init, register_func, run, eq, destroy, get_context
use my_data_type, only: my_data, type2data, data2type

type(eq), pointer :: d
type(my_data), target :: data1, data2

data1%a11 = 0
data1%a12 = -1
data1%a21 = 1
data1%a22 = 0

data2%a11 = 0
data2%a12 = 1
data2%a21 = 1
data2%a22 = 0

call init(d)
call register_func(d, derivs, type2data(data1))
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10)
call print_material_parameters(d)
print *
call register_func(d, derivs, type2data(data2))
call run(d, [0.0_dp, 1.0_dp], 0.1_dp, 10)
call print_material_parameters(d)
call destroy(d)

contains

subroutine print_material_parameters(d)
type(eq), intent(in) :: d
type(my_data), pointer :: ctx
ctx => data2type(get_context(d))
print "('Material parameters: ', f0.6, ' ', f0.6, ' ', f0.6, ' ', f0.6)", &
    ctx%a11, ctx%a12, ctx%a21, ctx%a22
end subroutine

function derivs(x, data) result(y)
use types, only: dp
real(dp), intent(in) :: x(2)
integer, intent(in) :: data(:)
real(dp) :: y(2)
type(my_data), pointer :: d
d => data2type(data)
y(1) = d%a11 * x(1) + d%a12 * x(2)
y(2) = d%a21 * x(1) + d%a22 * x(2)
end function

end program
