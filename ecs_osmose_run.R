rm(list = ls())

library(osmose)

setwd("./osmose_run/Base/master/")
run_osmose("ecs_all-parameters.csv",osmose="../osmose_4.3.3.jar")
