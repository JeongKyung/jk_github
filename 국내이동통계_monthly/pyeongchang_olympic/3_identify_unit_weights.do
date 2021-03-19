************************************************************************************
*******Causal Analysis of population net-inflow using synthetic control method******
*******Date:2020/03/03, last edited by Jeongkyung Won ******************************
************************************************************************************

**** 2. Identify townships chosen for constructing the synthetic units ****

cd "C:\Users\user\Dropbox\RA\synth\Data"

local idlist 61 64
local namelist bongpyeong daegwanryeong
local num=2

forvalues n=1/`num'{
	local i: word `n' of `idlist'
	local j: word `n' of `namelist'

	use `i'_netflow.dta,clear
	ren _Co_Number id
	ren _W_Weight weight_`j'
	drop if weight_`j'==0
	keep id weight_`j'
	save `i'_netflow_2.dta,replace
	}

local idlist 61 64
foreach i of local idlist{
	use `i'_netflow_2.dta,clear
	label define cd 1"신북읍" 2"춘천시동면" 5"춘천시남면" 8 "동내면" 12 "효저면" 19 "주문진읍" 23 "강동면" 27 "도계읍" 31 "홍천읍" 32 "화촌면" 41 "횡성읍" 45 "갑천면" 54 "영월군북면" 60 "대화면" 65 "정선읍" ///
	66 "고한읍" 73 "철원읍" 74 "김화읍" 76 "동송읍" 77 "근남면" 78 "화천읍" 89 "인제군북면" 91 "서화면" 94 "거진읍" 95 "현내면" 99 "양양군서면" 103 "강현면" 
	label value id cd
	save `i'_netflow_2.dta,replace
	}
