module LeastEffortBaseline

export path_of_least_effort, baseline

function path_of_least_effort(points::AbstractVector; available_idx=1:length(points))::Vector{Int}
    subset = points[available_idx]
    march = 1
    steps = [1]
    endpoint = available_idx[end-1]
    while march < endpoint
        x_dist = available_idx[(march+1):end] .- available_idx[march]
        y_dist = subset[(march+1):end] .- subset[march]
        (length(x_dist) == 0) && break
        march = last(argmin((y_dist ./ x_dist))) + last(steps)
        push!(steps, march)
    end
    return available_idx[steps]
end

function baseline(spectra::AbstractVector)
    N = length(spectra)
    points = 1:N
    hull = path_of_least_effort(spectra)
    baseline_points = spectra[hull]
    δx, δy = diff(hull), diff(baseline_points)
    m = δy ./ δx
    b = baseline_points[1:(end-1)] .- (m .* hull[1:(end-1)])
    trendline = 1
    correction = zeros(Float64, N)
    for idx in points
        if (idx < N) && (idx > hull[trendline+1])
            trendline += 1
        end
        correction[idx] = (m[trendline] * idx) .+ b[trendline]
    end
    return correction
end

function baseline(spectra::AbstractMatrix)
    return Matrix(hcat([baseline(r[:]) for r in eachrow(spectra)]...)')
end

end # module LeastEffortBaseline
