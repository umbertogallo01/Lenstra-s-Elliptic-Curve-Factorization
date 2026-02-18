# Lenstra Elliptic Curve Factorization (ECM)

Implementation of Lenstra's algorithm for integer factorization based on the theory of elliptic curves over finite fields.

## Project Description
Lenstra's Elliptic Curve Method (ECM) is a sub-exponential time algorithm specifically designed to find non-trivial factors of large composite integers. This implementation provides the mathematical framework for the factorization process through elliptic curve arithmetic.

## Technical Features
* **Elliptic Curve Arithmetic**: Implementation of point addition and point doubling operations over Z/nZ.
* **Factorization Strategy**: Iterative point multiplication to identify factors via Greatest Common Divisor (GCD) computations.
* **Exception Management**: Handling of cases where the algorithm identifies a factor or requires a change in the curve parameters.
