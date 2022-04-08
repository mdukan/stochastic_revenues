# Stochastic electricity price and wind feed-in 
The main Matlab script for running the model is called `ElecPriceSimWind_2020_p`. The script calls several functions needed to run the simulation, which have to be placed in the same folder as the main script (therefore it is best to download all the files at once). The data package `data_package_model_fin_2` contains data on: 
- installed capacity projections for solar PV and onshore wind interpolated on a yearly level (from TYNDP) 
- electricity prices from the start 2011 until the end of 2020 
- wind and solar PV feed-in from the start 2011 until the end of 2020 

In addition to this, the variables `fundamental_price_level` contains price projections until 2050, while `installCapacity0650` contains historical installed capacity and an installed capacity projection from the Ten Year Network Development Plan.

To conduct the simulation, follow these steps: 
- STEP1: define the price scenario. This can by any price scenario from a fundamental energy model like Balmorel or similar
- STEP2: insert file path for folder `PV_profile_generator`
- STEP3: define `StartYear` and `EndYear`: the starting and ending year from which the model learns and simulates stochastic prices and wind feed-in
- STEP4: define `BeginSimYear` and `EndSimYear`: the starting and ending years for the simulation. This must always be the same year. The model only simulates one year at a time and can not simulate multiple years. To simulate multiple years, conduct a separate simulation for each individual year'
- STEP5: define `numberSim` or the number of Monte Carlo simulations
- STEP6: define `SimHours` the number of hours in a year. NOTE: leap years have 8784 hours while non-leap years have 8760 hours 
- STEP7: save the entire output 

IMPORTANT: 
- save the variable `SimPrices` and entire output for every simulated year
- this script works on Matlab2016b. It might not work on newer versions of Matlab. 

# Revenue calculation

## Adjustment of the wind feed-in to fit an offshore wind production profile
The simulated wind feed-in or `SimWind` needs to be adjusted for an offshore wind production profile before it can be used in the revenue calculation. Each simulated year needs to be adjusted individually using the script `Polyfit_HornsRevB_2017to2019_n`. For this calculation, you will need these variables:  
- `CapFac_DEAll_2017to2019` or the calculated hourly capacity factors for wind production in Germany for years 2017 to 2019
- `HornsRevB_2017to2019` or the calculated hourly capacity factors for wind production from Horns Rev B for years 2017 to 2019
- `2020_1000sim_R001_LY` or the stochastic electricity price and wind feed-in simulation outcome for the year 2020 (each years simulation outcome needs to be adjusted individually) 

Proceed with these steps: 
- STEP1: in the script `Polyfit_HornsRevB_2017to2019_n` add the file-path `addpath` to your saved output for the year for which you want to adjust the wind feed-in
- STEP2: save the variable `SimWind_CapFac_UP_Fin` for each year. This is the upscaled offshore wind capacity factor

IMPORTANT: 
- the procedure needs to be conducted for each simulated year (for instance, 2020, 2025, 2030 etc.) 

## Calculating the CfD bid levels that equalize the NPV for the CfD and merchant project

Here you will need to switch between the Excel model `Financial Distress Model` and the Matlab scripts. 

Proceed with these steps: 
- STEP1: in the Excel model open the tab `Bid_app`. In ceels Q5 and Q6, write the range for which you want to estimate the CfD bid levels
- STEP2: copy and paste the prices in the range N5:N12 and open the Matlab script `NPVAppGen_R001`. This script calculates the revenues for the bid levels taking into account the copied bid prices. Copy the bid levels from Excel into variables `p1` to `p8`. The script also contains functions such as `AggRevP1`, which aggregate the revenues and interpolate between the simulated years. 
- STEP3: the script `NPVAppGen_R001` writes and saves the output as Excel files for each different CfD bid level. Designate a file path where you want to save the Excel files with the CfD revenues. You can save the Merchant revenues in a similar way. These are the same regardless of the CfD bid level. In the Excel model `Financial Distress Model` and under the tab `Bid_app` add the same filepath to the VBA code connected to the command button `Loop all rev`
- STEP4: copy and paste the saved merchant revenues in the Excel tab `Mer_Rev`
- STEP5: go back to the tab `Bid_app` and click the button `Loop all rev`. This should now open, copy and paste the CfD revenues for each of the bid levels and calculate the NPV for the CfD bid levels and merchant projects at the different debt sizes. The resulting output should be bid levels in cells X4:X14 which equalize the NPV's of the two offshore wind case studies. If the calculation does not derive an NPV equalizing bid level, choose another range in the cells Q5:Q6 and repeat the procedure until you find NPV equalizing bids for all debt sizes
- STEP6: once you have found all of the CfD bids, copy and paste these 11 bid levels and insert them into prices `p1` to `p11` in the script `ModelRevApp_R001`. Run the script to derive revenues for the 11 CfD bids, each corresponding to a different debt size
- STEP7: in Excel click the tab `CONTROL` and the button `Fetch data`. This should copy and paste the newely derived revenues into the tabs` CfD_Rev_p1` to `CfD_Rev_p11`. NOTE: you have to adjust the fill paths in the Matlab script and in the VBA code
- STEP8: in Excel click the button `Run All` in the tab `CONTROL`. The model will now calculate shareholder values under the different debt sizes and produce the results in tabs `D90` to `D40`

IMPORTANT: 
- for every different price scenario, you have to repeat the procedure

## Calculating optimal capital structure
The Excel model gives a summary of the average shareholder values for each debt size under the tab `Overview` and in the range C14:M15. Each shareholder value and debt size defines one point of a curve that has a maximum point. The maximum point is the point where shareholder value is the largest for some debt size. We now calculate the debt size that maximizes shareholder value using the following procedure: 

- STEP1: copy and paste the shareholder values in the range C14:M15 into separate Excel files using the Matlab script `ReadSaveShvR001`. Each file contains the shareholder values at all debt levels for either the CfD or merchant project. 
- STEP2: run the script `DebtFit_3` to derive the points of optimal capital structure, defined by a shareholder value and debt size. The script saves the results into a separate Excel file for which you need to define a pathname

