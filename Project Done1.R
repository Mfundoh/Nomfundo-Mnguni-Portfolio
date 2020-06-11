#####################################################
# Web Analysis Project 1
# Question 1
#######################################################

#setwd("c:/Users/student 20/Desktop")
setwd(choose.dir())
getwd()

Int_Data = read_excel("1555058318_internet_dataset.xlsx")
View(Int_Data)
str(Int_Data)
summary(Int_Data)

########################################################
# Question 2
########################################################

Web_Anov <- aov(Uniquepageviews ~ as.factor(Visits), data = Int_Data)
summary(Web_Anov)

Alpha <- 0.05
pvalue <- 2e-16

Alpha > pvalue # H0 - We reject the null hypothesis since the pvalue is less than Alpha

########################################################

# Question 3
########################################################

Exits_Anov <- aov(Exits ~., data = Int_Data)
summary(Exits_Anov)

# Exits has the following prbable factors: 
#                       Pr(>F)    
#   Bounces            2e-16 ***
#   Continent           1.62e-05 ***
#   Sourcegroup         4.89e-12 ***
#   Timeinpage          2e-16 ***
#   Uniquepageviews     2e-16 ***
#   Visits              0.0251 *

########################################################
# Question 4
#######################################################

Time_Anov <- aov(Timeinpage ~., data = Int_Data)
summary(Time_Anov)
# 
# The following variables that have effect on Timeonpage:
#
#                   Pr(>F) 
# Bounces           2e-16 ***
#   Exits           2e-16 ***
#   Continent       2.51e-06 ***
#   Sourcegroup     0.202    
# Uniquepageviews   2e-16 ***
#   Visits          2e-16 ***

######################################################
# Question 5
######################################################
str(Int_Data)
#Int_Data$Bounces <- sapply(Int_Data$Bounces, factor)
# str(Int_Data)
# View(Int_Data)


for(i in c("Bounces", "Exits","Timeinpage","Uniquepageviews","Visits"))
{
  Int_Data[,i] = as.factor(Int_Data[,i])
}

# Int_Data[,"Bounces"] = as.factor(Int_Data[,"Bounces"])
# 
# 
# as.factor(Int_Data[,"Bounces"])
# 


Bounce_Log <- glm(Bounces ~.,
                  family = binomial(link = 'logit'), 
                  data = Int_Data)
summary(Bounce_Log)
