# 1D_GaussianFit
Matlab script to fit univariate Gaussian Mixture Model (GMM) to a distribution of an observable


## General description
This script uses _fitgmdist_ function to fit the univariate Gaussian Mixture Model (GMM) to data, using a maximum likelihood estimator (MLE). 
GMM uses a superposition of _k_ normal distributions, with mixing proportion _x_<sub>k</sub>, mean value _µ_<sub>k</sub> and variance &sigma;<sub>k</sub><sup>2</sup>.
_fitgmdist_ operates on raw and not on histogrammed data, and is therefore independent on the bin settings later used in the visualization of the results.
As an otput, _fitgmdist_ function returns _GModel_ object, which contains the following properties:  
* number of compoenent in a mixture model
* mean, variance and proportion of the components
* negative log likelihood at the found minimum
* information criteria, i.e. Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC) 

Script is made to be used in interactive/explorative manner, and runs in sections. In the first section, no assumption on the fit model are made.
Tested are GMM models with up to _N_<sub>gaussians</sub> components, and the model with the minimum BIC value is taken as the one that describes data the best.


![GMM_fit_Ng3](https://github.com/mpopara/1D_GaussianFit/assets/40856779/b657a128-fc58-44bf-a596-5eb3e79ab9aa)


Alternatively, if there are presumptions about the distribution, in the following three code sections it also possible to fit specific GMM models to data, with up to three components. 
Script saves png and svg file of a histogram, overlayed with fit model as well as individual components in the mixture model.
Fit results can be easily transfered to a spreadsheet: in the workspace right-clik on the observable of interest and select _Copy_. Alternatively a line of a code can be added to automatize export of the fit results, 
or an entire workspace can be saved for convenient handling of data at later point.



## Input data

Currently script load a .txt file of a size Nx1 using _importdata_ function. For input file extensions which are not compatible with _importdata_, consider other import functions. 
Exemplary input file is provided in example_data directory.

## Dependencies

Fit_1D_GMM.m is a MATLAB script built on MATLAB R2019a, which requires _fitgmdist_ function introduced in R2014a.

## References

1. McLachlan, G., and D. Peel. Finite Mixture Models. Hoboken, NJ: John Wiley & Sons, Inc., 2000.
