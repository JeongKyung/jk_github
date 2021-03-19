*********************************************************************************************
***************************읍면동별 월별 인구 순전입별 데이터('16~'19)********************************
***************************Date:2020/02/20,last edited by Jeongkyung Won*********************
*********************************************************************************************

****5. Merge name and distance

cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data"

use "./인구이동통계/netflow/netflow_monthly/netflow_all_monthly.dta",clear

merge m:m id_town_h using name_town_and_dist_ktx.dta
order name_* id_town* year month *flow station dist_ktx 
keep if _merge==3
save ./인구이동통계/netflow/netflow_monthly/netflow_all_monthly_dist_merged.dta,replace

/*
Merge result

    Result                           # of obs.
    -----------------------------------------
    not matched                         1,179
        from master                         0  (_merge==1)
        from using                      1,179  (_merge==2)

    matched                           168,067  (_merge==3)
    -----------------------------------------
