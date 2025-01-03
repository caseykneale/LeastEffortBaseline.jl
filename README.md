# LeastEffortBaseline.jl

A baseline correction algorithm based on the concave rubber-band algorithm for spectral data processing. Instead of computing a convex hull on spectra a path of "least effort" is constructed where points in the spectrum (or vector) are chosen based on the 
least distance from the current point. 

In most cases I tested this on the result is identical to a rubber-band baseline correction using a convex hull. The main result is that the convex hull is expensive to compute and this is not. The implementation could be performance tuned further, but for the purposes I had for this, many years ago, this was beyond sufficient.

## Examples

### "Penicillin Fermentation Data"

See [ChemometricsData.jl](https://github.com/caseykneale/ChemometricsData.jl) and the following citation for access to this dataset.
```
Goldrick S., Duran-Villalobos C., K. Jankauskas, Lovett D., Farid S. S, Lennox B., (2019) Modern day control challenges for industrial-scale fermentation processes. Computers and Chemical Engineering.
```

Using a low performance economy laptop, this approach was compared to a naive convex hull based implementation. The following performance characteristics were observed:

| Algorithm      | Process Time (~1,130 spectra) | Heap Allocations | Gb Allocated |
| ------------- | ------------- | --- | --- |
| Convex Hull | 22.788s | 567,877,386 | 50.85 |
| Least Effort | 0.3s | 326,012 | 0.9017 |

This marks a ~75x performance increase over the naive implementation. Worth noting, there is still performance left on the table for tuning this algorithm to further reduce allocations, etc. This is good enough for open source. An example spectra is shown below:

![Alt text](images/penicillin.png?raw=true "penicillin baseline extraction")

Worth noting, I think these spectra are synthetic, but the details allude me at the moment. This is all from years ago.

### Paracetamol Data (HyperSpec)

See [HyperSpec documentation](https://r-hyperspec.github.io/hyperSpec/reference/paracetamol.html) for access to the paracetamol spectrum.

Below is an example baseline correction of a sample region in the paracetamol spectrum:

![Alt text](images/paracetamol_raw.png?raw=true "raw and baseline")
![Alt text](images/paracetamol_corrected.png?raw=true "corrected")


## Additional Notes

I probably won't be updating this at any point. I was encouraged by a friend to share more of my personal research, especially the old stuff to benefit others. I no longer have work in this field, and although I have a lot more I could share, I don't have the bandwidth to finalize most of it at this time.
