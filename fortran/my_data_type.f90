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
