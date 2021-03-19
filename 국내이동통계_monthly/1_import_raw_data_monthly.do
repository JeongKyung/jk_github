********************************************************************************************
***************************읍면동별 월별 인구 순전입별 데이터('16~'19)**********************************
***************************Date:2020/02/20,last edited by Jeongkyung Won********************
********************************************************************************************

****1. Generate in/outflow_monthly Datasets 

set more off
cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계"

**1) inflow_monthly

**주의:2016년은 fam male female 39,43,47, 17년~19년은 37,39,41 

foreach yr of num 2017/2019{
	infix in_sido 1-2 in_sig 3-5 in_emd 6-10 year 11-14 month 15-16 out_sido 19-20 out_sig 21-23 out_emd 24-28 reason 29 fam_size 37 male 39 female 41 ///
	using extr_`yr'.txt if out_sido!=50, clear 
  
	**시군구& 읍면동 행정동 코드 만들기
	foreach x in "out" "in"{ 
		gen double `x'_emd_cd2 = `x'_sido * 100000000 + `x'_sig * 100000 + `x'_emd
		gen double `x'_sig_cd2= `x'_sido * 1000 + `x'_sig
		format `x'_emd_cd2 `x'_sig_cd2 %13.0g
		}	

	*읍면동 내에서의 이동은 제외
	drop if out_emd_cd2==in_emd_cd2
	drop in_sig out_sig in_emd out_emd
	ren *_cd2 *
	
	*각 읍면동의 월별 전입 인구 계산
	bysort in_emd year month: egen inflow=sum(fam_size)
	order in_sido in_sig out_sido out_sig in_emd year month inflow
	drop reason fam_size male female
	save ./inflow/inflow_monthly/inflow_`yr'_monthly.dta,replace
}

**2) outflow_monthly 

**주의:2016년은 fam male female 39,43,47, 17년~19년은 37,39,41 

foreach yr of num 2017/2019{
	infix in_sido 1-2 in_sig 3-5 in_emd 6-10 year 11-14 month 15-16 out_sido 19-20 out_sig 21-23 out_emd 24-28 reason 29 fam_size 37 male 39 female 41 ///
	using extr_`yr'.txt if out_sido!=50, clear 
  
	**시군구& 읍면동 행정동 코드 만들기
	foreach x in "out" "in"{ 
		gen double `x'_emd_cd2 = `x'_sido * 100000000 + `x'_sig * 100000 + `x'_emd
		gen double `x'_sig_cd2= `x'_sido * 1000 + `x'_sig
		format `x'_emd_cd2 `x'_sig_cd2 %13.0g
		}	

	*읍면동 내에서의 이동은 제외
	drop if out_emd_cd2==in_emd_cd2
	drop in_sig out_sig in_emd out_emd
	ren *_cd2 *
	
	*각 읍면동의 월별 전입 인구 계산
	bysort out_emd year month: egen outflow=sum(fam_size)
	order out_sido out_sig in_sido in_sig out_emd year month outflow
	drop reason fam_size male female
	save ./outflow/outflow_monthly/outflow_`yr'_monthly.dta,replace
}


