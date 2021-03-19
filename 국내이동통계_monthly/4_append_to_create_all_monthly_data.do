*********************************************************************************************
***************************읍면동별 월별 인구 순전입별 데이터('16~'19)********************************
***************************Date:2020/02/20,last edited by Jeongkyung Won*********************
*********************************************************************************************

****4. Append to create _all_monthly.dta

cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly"

use netflow_2016_monthly.dta,clear

foreach yr of num 2017/2019{ 
	append using netflow_`yr'_monthly.dta
	}
 
sort id_town_h year month

save netflow_all_monthly.dta,replace
