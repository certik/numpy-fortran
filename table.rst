NumPy
Fortran

----

from numpy import size
a = array([1, 2, 3])
size(a)


real(dp) :: a(3)
a = [1, 2, 3]
size(a)

----

from numpy import shape
a = array([[1, 2, 3], [4, 5, 6]])
size(a, 0)
size(a, 1)

real(dp) :: a(2, 3)
a = reshape([1, 2, 3, 4, 5, 6], [2, 3])
size(a, 1)
size(a, 2)

----
