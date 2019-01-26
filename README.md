# AAA_MRI_Growth_analysis
To take MRI images of AAAs and obtain geometric features. We want to see if these features have a correlation with growth and progression of the disease.

    • Pint in the .mat files contains all the AAA surface points lying on each orthogonal cross section plane.
    • d  in the .mat files contains the centerline displacements from the line joining the first and last points of the AAA centerline.
    • ecc_maxdia is the eccentricity measured at the maximum diameter cross section. It is taken as ratio of maximum diameter to minimum diameter. Max diameter is calculated by measuring distance between two furthest points lying on that cross section plane. Min diameter is taken as min diameter passing through the centerline.
    • globmax_ecc is the max eccentricity throughout AAA measured as ratio of maximum diameter to min diameter.
    • globmax_per is the maximum perimeter for the entire AAA.
    • globmax_dia is the maximum diameter for the entire AAA.
    • globmindia is the minimum diameter throughout the AAA measured as smallest diameter passing through the centerline.
    • maxtort_disp is the maximum centerline displacement from the line joining the first and last point of the centerline of AAA.
    • per_maxdia as the perimeter at max diameter
    • tort_disp_maxdia is the displacement of the AAA centerline from the line joining the first and last points of the AAA centerline at the max diameter cross section.
    • tort_cl is the tortuosity measured as the ratio of the length of the centerline to the distance between the first and last point of the centerline of the AAA.
