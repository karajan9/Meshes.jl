# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    ShiftedPath(path, offset)

Traverse an object with the `path` shifted by an `offset`
that can be positive or negative.
"""
struct ShiftedPath{P<:Path} <: Path
  path::P
  offset::Int
end

function traverse(object, path::ShiftedPath)
  p = traverse(object, path.path)
  n = length(p)
  o = path.offset
  s = o ≥ 0 ? o : abs((n + o) % n)
  i1 = Iterators.cycle(p)
  i2 = Iterators.drop(i1, s % n)
  Iterators.take(i2, n)
end
