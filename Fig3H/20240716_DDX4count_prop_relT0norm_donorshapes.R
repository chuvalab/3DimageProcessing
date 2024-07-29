

####################################################################################################
## Celine Roelse                                                                                  ##
## 2024-07-16                                                                                     ##
## GC quantification and normalization of all Proportion experiments in 6B.1; normalizing on T0   ##
####################################################################################################

library(ggplot2)
library(ggthemes)
library(readxl)
library(Rmisc)
library(lattice)
library(plyr)
library(ggpubr)
library(dplyr)
library(ggsignif)
library(xlsx)


## Specify color-blind-compatible palette:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


## Set working directory
setwd("D:/R-projects/3Dpaperrepo/Fig3H")

## Read data files
p1 <- read_excel("20230731_WD19_DDX4count_volume_prop.xlsx")                   
p1 <- as.data.frame(p1)
p2 <- read_excel("20230728_WD17_DDX4count_volume_prop.xlsx")                   
p2 <- as.data.frame(p2) 
p3 <- read_excel("20230720_WD14B_DDX4count_volume_prop.xlsx")                   
p3 <- as.data.frame(p3) 
p4 <- read_excel("20231012_WD18A_DDX4count_volume_prop.xlsx")                   
p4 <- as.data.frame(p4) 

p3 <- subset(p3, Prop != "C")

p1$Age <- "19"
p2$Age <- "17"
p3$Age <- "14B"
p4$Age <- "18A"


#### Donor 1
p1tib <- as_tibble(p1)

T0DDX4_1 <- summarySE(subset(p1tib, p1tib$'Condition' == 'T=0 days'), na.rm=T, measurevar='DDX4', groupvars = 'Prop')
# A:     T0DDX4[1,3]
# B:     T0DDX4[2,3]
# C:     T0DDX4[3,3]
# CTRL:  T0DDX4[4,3]

p1tibA <- p1tib %>% filter(Prop=='A') %>% mutate(DDX4_normcor=DDX4/T0DDX4_1[1,3])
p1tibB <- p1tib %>% filter(Prop=='B') %>% mutate(DDX4_normcor=DDX4/T0DDX4_1[2,3])
p1tibC <- p1tib %>% filter(Prop=='C') %>% mutate(DDX4_normcor=DDX4/T0DDX4_1[3,3])
p1tibCTRL <- p1tib %>% filter(Prop=='CTRL') %>% mutate(DDX4_normcor=DDX4/T0DDX4_1[4,3])

p1tibnorm <- rbind(p1tibA, p1tibB, p1tibC, p1tibCTRL)


### Donor 2
p2tib <- as_tibble(p2)

T0DDX4_2 <- summarySE(subset(p2tib, p2tib$'Condition' == 'T=0 days'), na.rm=T, measurevar='DDX4', groupvars = 'Prop')
# A:     T0DDX4[1,3]
# B:     T0DDX4[2,3]
# C:     T0DDX4[3,3]
# CTRL:  T0DDX4[4,3]

p2tibA <- p2tib %>% filter(Prop=='A') %>% mutate(DDX4_normcor=DDX4/T0DDX4_2[1,3])
p2tibB <- p2tib %>% filter(Prop=='B') %>% mutate(DDX4_normcor=DDX4/T0DDX4_2[2,3])
p2tibC <- p2tib %>% filter(Prop=='C') %>% mutate(DDX4_normcor=DDX4/T0DDX4_2[3,3])
p2tibCTRL <- p2tib %>% filter(Prop=='CTRL') %>% mutate(DDX4_normcor=DDX4/T0DDX4_2[4,3])

p2tibnorm <- rbind(p2tibA, p2tibB, p2tibC, p2tibCTRL)


#### Donor 3
## CTRL WILL BE T0DDX4[3,3] IF THERE IS NO C (IN THE CASE OF WD14B). In WD14B, also don't add p1tibC in p1tibnorm: 

p3tib <- as_tibble(p3)

T0DDX4_3 <- summarySE(subset(p3tib, p3tib$'Condition' == 'T=0 days'), na.rm=T, measurevar='DDX4', groupvars = 'Prop')
# A:     T0DDX4[1,3]
# B:     T0DDX4[2,3]
# CTRL:  T0DDX4[3,3]

p3tibA <- p3tib %>% filter(Prop=='A') %>% mutate(DDX4_normcor=DDX4/T0DDX4_3[1,3])
p3tibB <- p3tib %>% filter(Prop=='B') %>% mutate(DDX4_normcor=DDX4/T0DDX4_3[2,3])
p3tibCTRL <- p3tib %>% filter(Prop=='CTRL') %>% mutate(DDX4_normcor=DDX4/T0DDX4_3[3,3])

p3tibnorm <- rbind(p3tibA, p3tibB, p3tibCTRL)


### Donor 4
p4tib <- as_tibble(p4)

T0DDX4_4 <- summarySE(subset(p4tib, p4tib$'Condition' == 'T=0 days'), na.rm=T, measurevar='DDX4', groupvars = 'Prop')
# A:     T0DDX4[1,3]
# B:     T0DDX4[2,3]
# C:     T0DDX4[3,3]
# CTRL:  T0DDX4[4,3]

p4tibA <- p4tib %>% filter(Prop=='A') %>% mutate(DDX4_normcor=DDX4/T0DDX4_4[1,3])
p4tibB <- p4tib %>% filter(Prop=='B') %>% mutate(DDX4_normcor=DDX4/T0DDX4_4[2,3])
p4tibC <- p4tib %>% filter(Prop=='C') %>% mutate(DDX4_normcor=DDX4/T0DDX4_4[3,3])
p4tibCTRL <- p4tib %>% filter(Prop=='CTRL') %>% mutate(DDX4_normcor=DDX4/T0DDX4_4[4,3])

p4tibnorm <- rbind(p4tibA, p4tibB, p4tibC, p4tibCTRL)


results <- rbind(p1tibnorm, p2tibnorm, p3tibnorm, p4tibnorm)

results <- subset(results, Condition != "Gel")

## Renaming 
results["Prop"][results["Prop"] == "CTRL"] <- "No MACS"
results["Prop"][results["Prop"] == "A"] <- "20% ITGA6+"
results["Prop"][results["Prop"] == "B"] <- "50% ITGA6+"
results["Prop"][results["Prop"] == "C"] <- "80% ITGA6+"

results["Condition"][results["Condition"] == "T=0 days"] <- "T=0d"
results["Condition"][results["Condition"] == "Floating"] <- "T=7d"

results["Organization"][results["Organization"] == "Correct"] <- "SC in"
results["Organization"][results["Organization"] == "Reverse"] <- "SC out"
results["Organization"][results["Organization"] == "Unclear"] <- "No org."

## Make plot

results$Prop <- factor(results$Prop, levels = c("No MACS", "20% ITGA6+", "50% ITGA6+", "80% ITGA6+")) 
results$Condition <- factor(results$Condition, levels = c("T=0d", "T=7d"))
results$Organization <- factor(results$Organization, levels = c("SC in", "Mixed", "SC out", "No org."))


ddx4plot <- ggplot(results, aes(y=log(DDX4_normcor), x=Prop, color=Organization, shape=Age)) +
  geom_jitter(aes(group=Condition), position=position_jitterdodge(dodge.width = 0.9), size = 3) + 
  geom_hline(yintercept=0, linetype = "dotted", color = "black") +
  ylab("DDX4+ cells/rhTestis (relative to T=0)") +
  theme_classic() +
  ylim(-2.08, 1.5) +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(size=rel(0.9)), 
        axis.text.x = element_text(size=rel(1.1), vjust = 0.5), 
        axis.text.y = element_text(size=rel(1.3), hjust = 0.5), 
        legend.text=element_text(size=rel(1))) +
  scale_color_manual(values=cbPalette[c(6, 1, 8, 4)], name = "Organisation") +
  scale_shape_manual(values=c(17, 15, 16, 18), name = "Donor") +
  labs(title="Relative DDX4+ count per rhTestis")

ddx4plot

ggsave("./Plots/20240726_Fig3H_comb_DDX4_LOG_prop_shape.pdf", width=5.5, height=3)
ggsave("./Plots/20240726_Fig3H_comb_DDX4_LOG_prop_shape.png", width=5.5, height=3)






