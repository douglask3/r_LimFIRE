# Intro

- Coupled vegetation-fire models aim to decribe fire as a function of fuel,moisture and igntions (Hantson et al. 2016)
- Humans affact fire in 3 ways:
	1. increased igntions with population and pasture (as incoporated in e.g. SPITFIRE and LmFire)
	1. Fragmentation factor, from crop and urban cover

Knorr et al. 2014 Used fAPAR as fuel idicator. But on sub-annual timestep, this is not fuel load, as dead, non pa vegetation
still contributes to fuel

Similarities to SimFire (Knorr et al. 2014), but able to test ignitions as well.
Includes postive and negative effects of same variable.

# Methods
- Under perfect conditions, iyt is assumed taht 100% of grid cell is burnt
- Prefect condition is plentyful fuel load, zero mositure content, saturation of either natural or anthropagenic ignitions, and no anthropagenic supressions
- If a factor is less than ideal (i.e, frgmented fuel, damo fuel, lack of ignitions or high crop or urban cover), this represents a limitation of fire.
- scaled to a limitation factor using equations...

## LimFire

### Fuel 
NPP from the preious 12 months.
Taken from MOD17A3

### Moisture

#### Live moisture

alpha

#### Dead moisture

EMC


### ignitions

#### lightning


#### human ignitions

### supression

#### agriculture

#### popdens


Some weakneness:
	- Some parts of the world havbe >100% burnt area per year (quantify). However, this is an asumption in most DGVM-fire models, many of which fail to simulate >30% burnt area anywhere.
        - Assumens only 1 fire season (quantify area with > 1 season)
	- Does not geographically weight live vs dead fuel moisture against fuel pools. In areas with high live fuel fraction, alpha would be more important than emc
	- Fuel could build up at lower fuel decompositions. However, the biggest influance on decomposition time is liutter size, with more thick, slow decaying fuel produced in forest veg types. Here, fuel is unlikley to be limitating even without the extra fuel being accounted of, so this is likley to make little dfference. Perhaps more import, fuel size on drying time is not taken into account, with large fuel retaining moisture for longer. However, most fuel in all dry or seasonal dry excostem loose their moisture in ~ 100hrs or less (...), far less than the monthly tiime step of the model. Again, this will therefore only affect the wettest veg types, where moisture will already be limiting.
	- Missing other influaces e.g. wind on spread.

## Data choice


### alpha
Unfortunately, there is no reliable global data set of soil moisture.We there- fore used the ratio of actual to equilibrium evapotranspiration (α), which is widely used as an index of plant-available mois- ture (Prentice et al., 1993), as a surrogate for soil moisture. This index is calculated from the CRU TS3.1 climate data as described in Gallego-Sala et al. (2010). Equilibrium evap- otranspiration refers to the water loss from a large homoge- neous area under constant atmospheric conditions. Estimated actual evapotranspiration depends on the rate of supply of moisture from the soil, which declines in proportion to soil water

# Discussion
- Model process base models also  incoporate simulation of rate of spread (which often includes moisture and fuel), both to incorporatwe affects of e.g.wind speed, and to obtain fire information such asd intensity to simnulate veg-fire feedback.
- Extension of model could incorportae wind as  a "scalar" increasing burnt area, rather than a limitation
- <<Brett>> showed simple relationships between e.g. fire frewquancy, inte ....,  which ould be obtained using this model if incorporated in DGVM


# Figures

## Fig 1
Each plot is limitation vs annual average burnt area scattered with limitation lione superimposed.
a) production (kg/m2)
b) moisture (weighted %)
c) Ignitions (no. of ignitions)
d) Suppression index (unitless)


# Fig 2

- Main Plot
- Map of limitation
a) GFED observations, going grey (no fire) to white (max fire) to match below
b) Map of contribution of limitation. This colours

	- Green: Fuel
	- Blue: Moisture
	- Red: Ignitions
	- grey: Supression
	- White: No limiation.

Make sure 100% limited and grey are same luminosity


# Fig 3
Maps of human impact

a) Overall impact: LimFire(control) - LimFire(no Humans)
b) Human Ignitions (white to red): LimFire(Control) - LimFire(no anthro ignitions) 
c) Human supression (white to blue): ditto.



# Fig S1
Each variable mapped

# Fig S2
Each limitation mapped

# Fig S3 
Map of fire anaomolie with each limitation lifted in turn



# Lit Review stuff
## Bistinas et al.:

- NPP biggest "fuel" type predictor
- alpha biggest live moisture predictor
- atmopsheric drying variables biggest indicator of dead fuel moisture
- cropland and grzing have roughly equal contribution, so would expect A in term to be ~= 1
- Pasture should have positive affect
- This techinque seperates out control groups to assess specific limitations, not possible with GLM (check).
- Influances on limitations (i.e, crop + urban etc) are linearly combined, before being combined using the relavent function, as per Bistinas et al.
