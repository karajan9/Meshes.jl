# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    Hexahedron(p1, p2, ..., p8)

A hexahedron with points `p1`, `p2`, ..., `p8`.
"""
struct Hexahedron{Dim,T,V<:AbstractVector{Point{Dim,T}}} <: Polyhedron{Dim,T}
  vertices::V
end

nvertices(::Type{<:Hexahedron}) = 8
nvertices(h::Hexahedron) = nvertices(typeof(h))

function (h::Hexahedron)(u, v, w)
  A1, A2, A4, A3,
  A5, A6, A8, A7 = coordinates.(h.vertices)
  Point((1-u)*(1-v)*(1-w)*A1 +
            u*(1-v)*(1-w)*A2 +
            (1-u)*v*(1-w)*A3 +
                u*v*(1-w)*A4 +
            (1-u)*(1-v)*w*A5 +
                u*(1-v)*w*A6 +
                (1-u)*v*w*A7 +
                    u*v*w*A8)
end

function measure(h::Hexahedron)
  A1, A2, A4, A3,
  A5, A6, A8, A7 = h.vertices
  t1 = Tetrahedron(A1, A2, A5, A7)
  t2 = Tetrahedron(A2, A6, A5, A7)
  t3 = Tetrahedron(A2, A6, A7, A8)
  t4 = Tetrahedron(A1, A2, A3, A7)
  t5 = Tetrahedron(A2, A3, A4, A7)
  t6 = Tetrahedron(A2, A3, A4, A8)
  sum(measure, [t1,t2,t3,t4,t5,t6])
end