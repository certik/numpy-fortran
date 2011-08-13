NumPy
Fortran

----

from numpy import size
a = array([1, 2, 3])
print size(a)


real(dp) :: a(3)
a = [1, 2, 3]
print *, size(a)

----

from numpy import shape
a = array([[1, 2, 3], [4, 5, 6]])
print size(a, 0)
print size(a, 1)

real(dp) :: a(2, 3)
a = reshape([1, 2, 3, 4, 5, 6], [2, 3])
print *, size(a, 1)
print *, size(a, 2)

----
