************************************************************************************
*******Causal Analysis of population net-inflow using synthetic control method******
*******Date:2020/03/03, last edited by Jeongkyung Won ******************************
************************************************************************************

**** 2. Synth ****

** Set-up **

use "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly\netflow_gangwon_monthly_v1.dta",clear

bysort id_town_h_2: gen count=_N
drop if count!=48 // drop several townships to resolve conformity error 		

egen id=group(id_town_h_2) //Assign short numeric values to each township for later convenience			

gen treated=(id==61|id==64|id==69) //봉평면, 대관령면, 북평면

save "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly\netflow_gangwon_monthly_v2.dta",replace


** Run Synth **
	
cd "C:\Users\user\Dropbox\RA\synth"

set more off

local y netflow  
local treated 61 64 // 봉평면 대관령면
local t1 1  // start period
local t2 26  // intervention
local t3 48 // end period			

	foreach i of local treated{
	
		use "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly\netflow_gangwon_monthly_v2.dta",clear

		tsset id month_from_2016
		drop if treated==1 & id!=`i'
		
		local predictor ""
			forvalues k = `t1'(1)`t2'{
			local predictor "`predictor' `y'(`k')"
			}			
		
			synth `y' `predictor', ///	
			trunit(`i') trperiod(`t2') ///
			mspeperiod(`t1'(1)`t2') resultsperiod(`t1'(1)`t3') nested ///
			keep(./Data/`i'_`y'.dta) replace fig 
			mat list e(V_matrix)		
			graph save ./graph/`i'_`y'_`t2'.gph, replace
			}


/*uncomment to run for inflow and outflow

set more off

local outcome inflow outflow  
local treated 61 64 // 봉평면 대관령면
local t1 1  // start period
local t2 26  // intervention
local t3 48 // end period			

	foreach i of local treated{
		foreach y of local outcome{
			use "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly\netflow_gangwon_monthly_v2.dta",clear

			tsset id month_from_2016
			drop if treated==1 & id!=`i'
		
			local predictor ""
				forvalues k = `t1'(1)`t2'{
				local predictor "`predictor' `y'(`k')"
				}			
		
				synth `y' `predictor', ///	
				trunit(`i') trperiod(`t2') ///
				mspeperiod(`t1'(1)`t2') resultsperiod(`t1'(1)`t3') nested ///
				keep(./Data/`i'_`y'.dta) replace fig 
				mat list e(V_matrix)		
				graph save ./graph/`i'_`y'_`t2'.gph, replace
				}
			}
			
			
			
