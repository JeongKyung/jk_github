************************************************************************************
*******Causal Analysis of population net-inflow using synthetic control method******
*******Date:2020/03/03, last edited by Jeongkyung Won ******************************
************************************************************************************

****1. Prepare Data ****

cd "C:\Users\user\Dropbox\내 PC (LAPTOP-ODROTJ7E)\Desktop\Dropbox\korea_ktx\JK\data\인구이동통계\netflow\netflow_monthly"
use ./netflow_all_monthly_dist_merged.dta, clear

drop station dist_ktx _merge //droping unnecessary variables
keep if name_prov=="강원도" 
keep if strmatch(name_town,"*읍")+strmatch(name_town,"*면")+strmatch(name_town,"*소")==1 //동 drop

**합쳐줘야 할 읍면동 list merge하기(출장소가 있거나,경계가 나뉘었거나,경계는 같은데 코드가 변한 경우), merge 결과 하단 참조
merge m:1 id_town_h_2 using ./subdata/boundaries_to_be_fixed.dta 
drop if _merge==2 
drop num_poin

*행정동 코드 하나로 통일
bysort id_town_hk: replace id_town_h=id_town_h[1] if _merge==3

*행정동 명칭도 하나로 통일
bysort id_town_h: replace name_town=name_town[1]
replace name_town="신동읍" if name_town=="신동읍함백출장소"
replace name_town="원덕읍" if name_town=="원덕읍임원출장소"

*같은 행정동이면 inflow, outflow, netflow 값 합쳐주기
bysort id_town_h year month: gen count=_n 

local varlist inflow outflow netflow 
foreach v of local varlist{
	by id_town_h year month: replace `v'=sum(`v')
	}
by id_town_h year month: keep if count==_N
drop id_town_hk _merge count //droping unnecessary variables

**months_from_2016
gen month_from_2016=month
replace month_from_2016=month+12 if year==2017
replace month_from_2016=month+24 if year==2018
replace month_from_2016=month+36 if year==2019
order month_from_2016, before(inflow)

save netflow_gangwon_v1.dta,replace

/*
  Result                           # of obs.
    -----------------------------------------
    not matched                         4,904
        from master                     4,895  (_merge==1)
        from using                          9  (_merge==2)

    matched                               763  (_merge==3)
    -----------------------------------------




