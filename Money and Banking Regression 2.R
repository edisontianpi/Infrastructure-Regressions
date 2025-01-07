#In case you want to clear environment 
#rm(list=ls())

```{r setup, include=TRUE}
# LOADING LIBRARIES
install.packages("readxl")
install.packages("tidyverse")
install.packages("stargazer")

library(readxl)
library(tidyverse)
library(stargazer)

# IMPORT DATA
df <- read_excel("C:/Users/etian000/Downloads/Fred Infrastructure and GDP 2.xls", 
                 skip = 17)

# CHECK COLUMN NAMES
print(colnames(df))

# RENAME COLUMNS (ensure the names are correct)
df <- df %>% rename(
  DATE = observation_date,
  GDP = GDPC1_PCH,
  UNEMP = UNRATE_PCH,
  CPI = FPCPITOTLZGUSA_PCH,
  HIGH = TLHWYCONS_PCH,
  GOVEX = G160581A027NBEA_PCH,
  PINDEX = PCU336510336510P_PCH,
  HWORK = IPUDN23731L200000000_PCH,
  RIDER = TRANSIT_PCH
)

# LINEAR MODELS AND RESULTS
#Model 1
#model_one <- lm(UNEMP ~ CPI, data = df)
#model_two <- lm(UNEMP ~ CPI + GDP, data = df)
#model_three <- lm(UNEMP ~ CPI + GDP + DEBT, data = df)

model_1a <- lm(GDP ~ HIGH, data = df)
model_1b <- lm(GDP ~ HIGH + GOVEX, data = df)
model_1c <- lm(GDP ~ HIGH + GOVEX + PINDEX, data = df)
model_1d <- lm(GDP ~ HIGH + GOVEX + PINDEX + HWORK, data = df)
model_1e <- lm(GDP ~ HIGH + GOVEX + PINDEX + HWORK + RIDER, data = df)

model_2a <- lm(UNEMP ~ HIGH, data = df)
model_2b <- lm(UNEMP ~ HIGH + GOVEX, data = df)
model_2c <- lm(UNEMP ~ HIGH + GOVEX + PINDEX, data = df)
model_2d <- lm(UNEMP ~ HIGH + GOVEX + PINDEX + HWORK, data = df)
model_2e <- lm(UNEMP ~ HIGH + GOVEX + PINDEX + HWORK + RIDER, data = df)

model_3a <- lm(CPI ~ HIGH, data = df)
model_3b <- lm(CPI ~ HIGH + GOVEX, data = df)
model_3c <- lm(CPI ~ HIGH + GOVEX + PINDEX, data = df)
model_3d <- lm(CPI ~ HIGH + GOVEX + PINDEX + HWORK, data = df)
model_3e <- lm(CPI ~ HIGH + GOVEX + PINDEX + HWORK + RIDER, data = df)

#merged_data <- merge(GDP, HIGH, by = "YEAR") 
#merged_data <- merge(merged_data, GOVEX, by = "YEAR") 
#merged_data <- merge(merged_data, PINDEX, by = "YEAR") 
#merged_data <- merge(merged_data, HWORK, by = "YEAR") 
#merged_data <- merge(merged_data, RIDER, by = "YEAR") 


# PRINT RESULTS
#Model 1
stargazer(model_1a, model_1b, model_1c, model_1d, model_1e,
          title = "GDP and Infrastructure", 
          align = TRUE, 
          type = "html", 
          out = "GDP_and_Infrastructure")

getwd()

browseURL("gdp_and_infrastructure.html")

#Model 2
# PRINT RESULTS
stargazer(model_2a, model_2b, model_2c, model_2d, model_2e,
          title = "Unemployment and Infrastructure", 
          align = TRUE, 
          type = "html", 
          out = "Unemployment_and_Infrastructure.html")


getwd()

browseURL("Unemployment_and_Infrastructure.html")

# PRINT RESULTS Model 3
stargazer(model_3a, model_3b, model_3c, model_3d, model_3e,
          title = "CPI and Infrastructure", 
          align = TRUE, 
          type = "html", 
          out = "CPI_and_Infrastructure")


getwd()

browseURL("CPI_and_Infrastructure")


# PLOT RESIDUALS FOR MODEL ONE
par(mfrow = c(1, 3))  # Set up a 1x3 plotting area for three plots

# Residuals vs. Fitted for Model One
plot(fitted(model_one), residuals(model_one),
     main="Residuals vs. Fitted for Model One",
     xlab="Fitted Values", ylab="Residuals")
abline(h=0, col="#7E9BBC", lty=2)  # Horizontal line at y=0

# Residuals vs. Fitted for Model Two
plot(fitted(model_two), residuals(model_two),
     main="Residuals vs. Fitted for Model Two",
     xlab="Fitted Values", ylab="Residuals")
abline(h=0, col="#7E9BBC", lty=2)

# Residuals vs. Fitted for Model Three
plot(fitted(model_three), residuals(model_three),
     main="Residuals vs. Fitted for Model Three",
     xlab="Fitted Values", ylab="Residuals")
abline(h=0, col="#7E9BBC", lty=2)

# Reset plotting area
par(mfrow = c(1, 1))

#stargazer(model_one, model_two, model_three, 
#          title="Results", align=TRUE, 
#          type = "html", out = "linearmodel_1.html")
#stargazer(model_one, model_two, model_three, 
#          title="Results", align=TRUE, 
 #         type = "text")

# PLOT RESIDUALS
#plot(fitted(model_one), residuals(model_one),
#     main="Residuals vs. Fitted Values",
#     xlab="Fitted Values", ylab="Residuals")
#abline(h=0, col="#7E9BBC", lty=7)  # Adds a horizontal line at y=0

