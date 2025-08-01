ENV["PYTHON"]="C:\\Users\\name.surname\\AppData\\Local\\Programs\\Python\\Python313\\python.exe"

using PyCall

function generate_mesh(width, thickness, name)
    np = pyimport("numpy")
    shapely = pyimport("shapely")
    shapely.affinity = pyimport("shapely.affinity")
    clip_by_rect = pyimport("shapely.ops").clip_by_rect
    OrderedDict = pyimport("collections").OrderedDict
    mesh_from_OrderedDict = pyimport("femwell.mesh").mesh_from_OrderedDict

    core = shapely.geometry.box(-width / 2, 0, +width / 2, thickness)
    env = shapely.affinity.scale(core.buffer(5, resolution = 8), xfact = 0.5)

    polygons = OrderedDict(
        core = core,
        box = clip_by_rect(env, -np.inf, -np.inf, np.inf, 0),
        clad = clip_by_rect(env, -np.inf, 0, np.inf, np.inf),
    )

    resolutions = Dict("core" => Dict("resolution" => 0.03, "distance" => 0.5))

    mesh = mesh_from_OrderedDict(
        polygons,
        resolutions,
        default_resolution_max = 0.1,
        filename = "$name.msh",
    )

end
