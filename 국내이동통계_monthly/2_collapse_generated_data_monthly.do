*********************************************************************************************
***************************읍면동별 월별 인구 순전입별 데이터('16~'19)********************************
***************************Date:2020/02/20,last edited by Jeongkyung Won*********************
*********************************************************************************************

****2. Collapsing the generated data by(township, year, month)

cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계"

foreach v in "in" "out"{
	foreach yr of num 2016/2019{ 
		use ./`v'flow/`v'flow_monthly/`v'flow_`yr'_monthly.dta,clear
		collapse `v'flow,by(`v'_emd year month)
		ren `v'_emd emd
		save ./`v'flow/`v'flow_monthly/collapsed_`v'flow_`yr'_monthly.dta,replace
		}
	}
