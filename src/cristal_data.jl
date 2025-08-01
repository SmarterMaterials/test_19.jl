"""
    Creation of optical properties of the materials
"""

struct Coef
    A::Float32
    B::Float32
    C::Float32
    D::Float32
    E::Float32
    p::Float32
    q::Float32
end

struct Ref_Idx
    sx
    sy
    sz
    λ₁::Float32 
    λ₂::Float32
end


function Sellemeyer(w, MAT)
    n = sqrt(MAT.A + (MAT.B*w^MAT.p)/(w^MAT.p-MAT.C) + (MAT.D*w^MAT.q)/(w^MAT.q-MAT.E))
end

guide = Ref_Idx(
    Coef(2.1495, 1.0203, 0.042378, 0.5531, 72.3045, 1.9951, 1.9567), 
    Coef(2.1308, 1.0564, 0.042523, 0.6927, 54.8505, 2.0017, 1.7261),
    Coef(2.1931, 1.2382, 0.059171, 0.5088, 53.2898, 1.8920, 2.0000),
    0.5, 
    3.5
    )


substrate = Ref_Idx(
    Coef(2.1239, 0.14274, 18.477, 0.87370, 0.045906, 2, 2), 
    Coef(2.0649, 0.15529, 19.373, 0.95463, 0.045505, 2, 2),
    Coef(1.6539, 0.34767, 29.378, 1.6482, 0.038825, 2, 2),
    0.5, 
    2.5
    )

air = Ref_Idx(
    1,
    1,
    1,
    0.5, 
    3.5
    )
