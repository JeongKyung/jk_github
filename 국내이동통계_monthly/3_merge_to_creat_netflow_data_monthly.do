*********************************************************************************************
***************************읍면동별 월별 인구 순전입별 데이터('16~'19)********************************
***************************Date:2020/02/20,last edited by Jeongkyung Won*********************
*********************************************************************************************

****3. Merge inflow& outflow to creat netflow.dta for each year 

cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계"

foreach yr of num 2016/2019{ 
	use ./inflow/inflow_monthly/collapsed_inflow_`yr'_monthly.dta,clear
	merge m:m emd year month using ./outflow/outflow_monthly/collapsed_outflow_`yr'_monthly.dta
	keep if _merge==3
	drop _merge
	ren emd id_town_h
	gen netflow=inflow-outflow
	order id_town_h year month inflow outflow netflow
	save ./netflow/netflow_monthly/netflow_`yr'_monthly.dta,replace
	}

	
/* Merge Results

  Result                           # of obs.
    -----------------------------------------
    not matched                           617
        from master                       572  (_merge==1)
        from using                         45  (_merge==2)

    matched                            41,970  (_merge==3)
    -----------------------------------------
(617 observations deleted)
(note: file ./netflow/netflow_monthly/netflow_2017_monthly.dta not found)
file ./netflow/netflow_monthly/netflow_2017_monthly.dta saved

    Result                           # of obs.
    -----------------------------------------
    not matched                           620
        from master                       559  (_merge==1)
        from using                         61  (_merge==2)

    matched                            42,061  (_merge==3)
    -----------------------------------------
(620 observations deleted)
(note: file ./netflow/netflow_monthly/netflow_2018_monthly.dta not found)
file ./netflow/netflow_monthly/netflow_2018_monthly.dta saved

    Result                           # of obs.
    -----------------------------------------
    not matched                           630
        from master                       554  (_merge==1)
        from using                         76  (_merge==2)

    matched                            41,982  (_merge==3)
	
