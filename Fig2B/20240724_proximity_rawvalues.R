
#######################################################################################
## Celine Roelse                                                                     ##
## 2024-07-15                                                                        ##
## Take output files from Imaris (delete first row by hand) and plot into violin     ##
#######################################################################################

library(ggplot2)
library(ggthemes)
library(readxl)
library(ggpubr)
library(xlsx)

## Set working directory
setwd("D:/R-projects/3Dpaperrepo/Fig2B")


## Read data file
uncnr2 <- read_excel("20231117_noorg_15.35.50_NR2.xls")                   
uncnr2 <- as.data.frame(uncnr2)
uncnr2$Organization <- "No-org"
uncnr2$Marker <- "NR2F2"

mixnr2 <- read_excel("20231120_mixed_17.49.06_NR2.xls")                   
mixnr2 <- as.data.frame(mixnr2)
mixnr2$Organization <- "Mixed"
mixnr2$Marker <- "NR2F2"

outnr2 <- read_excel("20231120_scout_17.55.40_NR2.xls")                   
outnr2 <- as.data.frame(outnr2)
outnr2$Organization <- "SCout"
outnr2$Marker <- "NR2F2"

ctrlnr2 <- read_excel("20240725_testisWM_14.02.53_NR2.xls")                   
ctrlnr2 <- as.data.frame(ctrlnr2)
ctrlnr2$Organization <- "CTRL"
ctrlnr2$Marker <- "NR2F2"


## Make plot:  

df <- rbind(uncnr2, mixnr2, outnr2, ctrlnr2)
names(df)[1] <- "Distance"

df$Organization <- factor(df$Organization , levels = c("CTRL", "SCout", "Mixed", "No-org"))


nr2plotraw <- ggplot(df, aes(x=Organization, y=Distance)) +
  geom_violin() + 
  geom_jitter(height = 0, width = 0.2, size = 0.2) +
  theme_classic() + 
  geom_hline(yintercept=0, linetype = "dotted", color = "black")

nr2plotraw 

ggsave("20240725_org_raw_violinplot_NR2.pdf", width=4, height=3)
ggsave("20240725_org_raw_violinplot_NR2.png", width=4, height=3)

