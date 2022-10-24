capture log close
set more off

cd G:

*1

use mrc_table3.dta, clear

*2
keep if cohort == 1980

*3

gen mobil_var = par_q1*k_q5

*4

keep name super_opeid count mobil_var

*5

keep if super_opeid==2687 | super_opeid==2688 | super_opeid==2689 | super_opeid==2690 | super_opeid==2691 | super_opeid==2692 | super_opeid==2693 | super_opeid==2694 | super_opeid==2696 | super_opeid==2697 | super_opeid==2698 | super_opeid==2823 | super_opeid==4759 | super_opeid==7022 | super_opeid==7273 | super_opeid==8611 | super_opeid==10051 | super_opeid==10097

*6

collapse (mean) count (mean) mobil_var [iweight=count]

*7

gen name = "CUNY System"
gen super_opeid = 9999

*8

save "G:\CUNYsystemAEItest.dta"

*9

use mrc_table3.dta, clear
keep if cohort == 1980
gen mobil_var = par_q1*k_q5
append using CUNYsystemAEItest.dta

*10

drop if super_opeid==2687 | super_opeid==2688 | super_opeid==2689 | super_opeid==2690 | super_opeid==2691 | super_opeid==2692 | super_opeid==2693 | super_opeid==2694 | super_opeid==2696 | super_opeid==2697 | super_opeid==2698 | super_opeid==2823 | super_opeid==4759 | super_opeid==7022 | super_opeid==7273 | super_opeid==8611 | super_opeid==10051 | super_opeid==10097

*11
drop if super_opeid==-1
drop if count<200
drop if iclevel==3
drop if tier==14

*12
rename cfips cty
merge m:1 cty using "G:\health_ineq_online_table_12.dta"

*13
drop if _merge==1

*14
*dropping unmatched counties from health dataset which were blank over original dataset's variables to clean data
drop in 2132/4220

*14a

sort mobil_var
* The institution with the lowest mobility rate among the dataset is Hampden Sydney College with a rate of .0050762. The five lowest mobility rates include Hampden Syndney College, Furman University(.00584), University of Puget Sound(.00615), Hope College(.00639), and Kenyon College(.0064).

*14b

sort state mobil_var
* The institution with the highest mobility rate in Utah is Dixie State University with a rate of .02205. The three highest mobility rates include Dixie State University, Southern Utah University(.01441), and University of Utah(.01335).

*14c
sort mig_outflow
* The college located in the county with the highest migration outflow rate is University of Mary Washington. It is located in Fredericksberg City County, Virginia, and this county has a migration outflow rate of .12661.

*15
save "G:\AEItestfinaldata.dta"



