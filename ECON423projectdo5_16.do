clear

capture log close

log using ECON423projectlog.txt, text replace

cd G:

infix using "G:\project1.dct"

*probit model

probit enterprise highest_grade c.highest_grade#c.highest_grade i.gender i.rural age c.age#c.age if age>=18 & age<=64
predict probitenterprise
margins, dydx(highest_grade)
margins, dydx(age)
margins, dydx(gender)
margins, dydx(rural)
summarize probitenterprise
summarize enterprise highest_grade age gender rural if e(sample)

*max likelihood grade 4.71
*max likelihood age 35.26

*logit model

logit enterprise highest_grade c.highest_grade#c.highest_grade i.gender i.rural age c.age#c.age if age>=18 & age<=64
predict logitenterprise
margins, dydx(highest_grade)
margins, dydx(age)
margins, dydx(gender)
margins, dydx(rural)
summarize logitenterprise

*max likelihood grade 4.69
*max likelihood age 35.43

*in both models, all variables have statistically significant coefficients. the coefficients in the logit model are larger, which is to be expected. when we compare the ages and highest grades at which probabilities are maximized they are practically the same. similarly, the marginal effects of age and highest grade are practically the same in both the probit model and the logit model. stata reports statistically insignificant marginal effects of age and statistically significant marginal effects of highest grade. however, neither of their marginal effects are economically significant, as they indicate miniscule changes to the probability of having an enterprise for greater age or education.

*test of models

probit enterprise highest_grade c.highest_grade#c.highest_grade i.gender i.rural age c.age#c.age logitenterprise if age>=18 & age<=64

logit enterprise highest_grade c.highest_grade#c.highest_grade i.gender i.rural age c.age#c.age probitenterprise if age>=18 & age<=64

*the coefficient of the logit estimates in this probit model is statistically significant, while the coefficient of the probit estimates in this logit model is not. this indicates that we should prefer the logit model to the probit model. 

