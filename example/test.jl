using test_19

using LinearAlgebra
using SparseArrays


using Gridap
using Gridap.Geometry
using Gridap.Visualization
using Gridap.ReferenceFEs
using GridapGmsh
using GridapMakie, CairoMakie

using Femwell.Maxwell.Waveguide

#settings
λ1 = 1.5
Id = diagonal_tensor(VectorValue([1.0, 1.0, 1.0]))
#---------------------------------------
air_layer = diagonal_tensor(VectorValue([1.0^2, 1.0^2, 1.0^2]))
#---------------------------------------
KTA_layer = diagonal_tensor(VectorValue([(Sellemeyer(λ1, guide.sx))^2, (Sellemeyer(λ1, guide.sy))^2, (Sellemeyer(λ1, guide.sz))^2]))
#---------------------------------------
KTP_layer = diagonal_tensor(VectorValue([(Sellemeyer(λ1, substrate.sx))^2, (Sellemeyer(λ1, substrate.sy))^2, (Sellemeyer(λ1, substrate.sz))^2]))

#---------------------------------------

generate_mesh(2, 2, "mesh")

model = GmshDiscreteModel("mesh.msh")
Ω = Triangulation(model)

labels = get_face_labeling(model)

#epsilons = ["core" => KTA_layer, "box" => KTP_layer, "clad" => air_layer]

ε(tag) = Dict(get_tag_from_name(labels, u) => v for (u, v) in epsilons)[tag]

τ = CellField(get_face_tag(labels, num_cell_dims(model)), Ω)

modes = calculate_modes(model, ε ∘ τ, λ = 1.5, num = 2, order = 1)