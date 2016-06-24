# Intro
- Coupled vegetation-fire models aim to decribe fire as a function of fuel,moisture and igntions (Hantson et al. 2016)
- Humans affact fire in 3 ways: 
	1. increased igntions with population and pasture (as incoporated in e.g. SPITFIRE and LmFire)
	1. Fragmentation factor, from crop and urban cover

# Methods
- Under perfect conditions, iyt is assumed taht 100% of grid cell is burnt
- Prefect condition is plentyful fuel load, zero mositure content, saturation of either natural or anthropagenic ignitions, and no anthropagenic supressions
- If a factor is less than ideal (i.e, frgmented fuel, damo fuel, lack of ignitions or high crop or urban cover), this represents a limitation of fire.
- scaled to a limitation factor using equations...

Some weakneness:
	- Some parts of the world havbe >100% burnt area per year (quantify). However, this is an asumption in most DGVM-fire models, many of which fail to simulate >30% burnt area anywhere.
        - Assumens only 1 fire season (quantify area with > 1 season)


# Discussion
- Model process base models also  incoporate simulation of rate of spread (which often includes moisture and fuel), both to incorporatwe affects of e.g.wind speed, and to obtain fire information such asd intensity to simnulate veg-fire feedback.
- Extension of model could incorportae wind as  a "scalar" increasing burnt area, rather than a limitation
- <<Brett>> showed simple relationships between e.g. fire frewquancy, inte ....,  which ould be obtained using this model if incorporated in DGVM

# Lit Review stuff
## Bistinas et al.: 

- NPP biggest "fuel" type predictor
- alpha biggest live moisture predictor
- atmopsheric drying variables biggest indicator of dead fuel moisture
- cropland and grzing have roughly equal contribution, so would expect A in term to be ~= 1
- Pasture should have positive affect
- This techinque seperates out control groups to assess specific limitations, not possible with GLM (check).
- Influances on limitations (i.e, crop + urban etc) are linearly combined, before being combined using the relavent function, as per Bistinas et al.

