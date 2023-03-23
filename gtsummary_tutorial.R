# Installing required packges

install.packages("gtsummary")
install.packages("survival")

# Loading packages

library(gtsummary)
library(tidyverse)
library(survival)

# creating a database

ex <- trial

# Visualization of the data frame

head(ex)

# building a table based on treatment, response, time until death and marker

ex %>% 
  select(trt, response, ttdeath, marker) %>% 
  tbl_summary(by = trt, missing = "no") %>% 
  add_p() %>% # adding p value
  add_overall() %>% # adding overall value
  add_n() %>% # adding the number of participants
  bold_labels() # Labels in bold

# building a regression model

model <- glm(response ~ trt + age + grade, trial, family = binomial)

# base visualization of the model

summary(model)

# using  tbl_regression to display the regression result's 

model1 <- tbl_regression(model, exponentiate = TRUE)

# building a survival model

model2 <- coxph(Surv(ttdeath, death) ~ trt + grade + age, ex) %>% 
  tbl_regression(exponentiate = TRUE)

# Merging tables

table <- tbl_merge(
  tbls = list(model1, model2),
  tab_spanner = c("**Tumor Response**", "**Time to Death**")
)

# Saving the table as .html

table %>% 
  as_gt() %>% 
  gt::gtsave(filename = "test.html")
