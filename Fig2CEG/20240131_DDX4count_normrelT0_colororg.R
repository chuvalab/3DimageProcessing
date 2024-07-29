
#####################################################################################################
## Celine Roelse                                                                                   ##
## 2024-01-31                                                                                      ##
## GC quantification and normalization of rhTestis experiment: ROCK-i vs. RevitaCell vs. CEPT      ##
#####################################################################################################

library(ggplot2)
library(ggthemes)
library(readxl)
library(Rmisc)
library(lattice)
library(plyr)
library(ggpubr)
library(dplyr)
library(xlsx)

## Specify color-blind-compatible palette:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "gray15")

## Set working directory
setwd("D:/R-projects/3Dpaperrepo/Fig2CEG")



###### Fig. 2E: 

## Read data file
p1 <- read_excel("20240131_DDX4_volume.xlsx")                   
p1 <- as.data.frame(p1)

## Normalize DDX4 count by expected proportion: 
# Per Condition and Prop, divide by that category's mean volume (i.e., 12 categories)
# Normalize based on T0 count so that T0 becomes 1 for each Prop.  
p1_original <- p1

p1tib <- as_tibble(p1)

p1tib$DDX4_norm <- p1tib$DDX4

T0DDX4 <- summarySE(subset(p1tib, p1tib$'Condition' == 'T=0 days'), na.rm=T, measurevar='DDX4_norm', groupvars = 'Prop')

p1tib1 <- p1tib %>% filter(Prop=='1') %>% mutate(DDX4_norm=DDX4/T0DDX4[1,3])
p1tib2 <- p1tib %>% filter(Prop=='2') %>% mutate(DDX4_norm=DDX4/T0DDX4[2,3])
p1tib3 <- p1tib %>% filter(Prop=='3') %>% mutate(DDX4_norm=DDX4/T0DDX4[3,3])
p1tib4 <- p1tib %>% filter(Prop=='4') %>% mutate(DDX4_norm=DDX4/T0DDX4[4,3])
p1tib5 <- p1tib %>% filter(Prop=='5') %>% mutate(DDX4_norm=DDX4/T0DDX4[5,3])
p1tib6 <- p1tib %>% filter(Prop=='6') %>% mutate(DDX4_norm=DDX4/T0DDX4[6,3])

p1tibnorm <- rbind(p1tib1, p1tib2, p1tib3, p1tib4, p1tib5, p1tib6)

## Renaming 
p1tibnorm$Prop <- as.character(p1tibnorm$Prop)

p1tibnorm["Condition"][p1tibnorm["Condition"] == "T=0 days"] <- "T=0d"
p1tibnorm["Condition"][p1tibnorm["Condition"] == "Floating"] <- "T=7d"

p1tibnorm["Organization"][p1tibnorm["Organization"] == "Reverse"] <- "SC out"
p1tibnorm["Organization"][p1tibnorm["Organization"] == "Unclear"] <- "No org."


## Make plot:  #DDX4/rhTestis norm to T=0d
ddx4.p1tibnorm.summ <- summarySE(p1tibnorm, na.rm=T, measurevar = 'DDX4_norm', groupvars = c('Prop', 'Condition', 'Organization'))

ddx4.p1tibnorm.summ$Condition <- factor(ddx4.p1tibnorm.summ$Condition, levels = c("T=0d", "T=7d"))
p1tibnorm$Condition <- factor(p1tibnorm$Condition, levels = c("T=0d", "T=7d"))

ddx4.p1tibnorm.summ$Organization <- factor(ddx4.p1tibnorm.summ$Organization, levels = c("Mixed", "SC out", "No org."))
p1tibnorm$Organization <- factor(p1tibnorm$Organization, levels = c("Mixed", "SC out", "No org."))


p1tibnorm$logddx <- log(p1tibnorm$DDX4_norm)

ddx4plot <- ggplot(ddx4.p1tibnorm.summ, aes(y=log(DDX4_norm), x=Prop, fill = Condition)) +
  geom_bar(position="dodge", stat = "identity") +
  geom_point(data=p1tibnorm, aes(y=logddx, x=Prop, group=Condition, color=Organization), position = position_dodge(width=0.9), size = 2.5, alpha = 0.8) +
  geom_hline(yintercept=0, linetype = "dotted", color = "black") +
  ylab("ln DDX4+ T=7d/T=0d per rhTestis") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(size=rel(0.9)), 
        axis.text.x = element_text(size=rel(1.1), vjust = 0.5), 
        axis.text.y = element_text(size=rel(1.3), hjust = 0.5), 
        legend.text=element_text(size=rel(1))) +
  scale_fill_manual(values=cbPalette[c(1, 2)], name = "Timepoint") +
  scale_color_manual(values=cbPalette[c(9, 8, 4)]) 

ddx4plot

ggsave("./Plots/20240131_DDX4count_normrel0_colororg.pdf", width=6.5, height=3)
ggsave("./Plots/20240131_DDX4count_normrel0_colororg.png", width=6.5, height=3)


###### Fig. 2C: 

## Absolute # DDX4/rhTestis: 
ddx4.p1tib.summ <- summarySE(p1tibnorm, na.rm=T, measurevar = 'DDX4', groupvars = c('Prop', 'Condition', 'Organization'))

ddx4.p1tib.summ$Condition <- factor(ddx4.p1tib.summ$Condition, levels = c("T=0d", "T=7d"))
p1tibnorm$Condition <- factor(p1tibnorm$Condition, levels = c("T=0d", "T=7d"))

ddx4.p1tib.summ$Organization <- factor(ddx4.p1tib.summ$Organization, levels = c("Mixed", "SC out", "No org."))
p1tibnorm$Organization <- factor(p1tibnorm$Organization, levels = c("Mixed", "SC out", "No org."))


absddx4plot <- ggplot(ddx4.p1tib.summ, aes(y=DDX4, x=Prop, fill = Condition)) +
  geom_bar(position="dodge", stat = "identity") +
  geom_point(data=p1tibnorm, aes(y=DDX4, x=Prop, group=Condition, color=Organization), position = position_dodge(width=0.9), size = 2.5, alpha = 0.8) +
  ylab("n DDX4+ cells per rhTestis") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(size=rel(0.9)), 
        axis.text.x = element_text(size=rel(1.1), vjust = 0.5), 
        axis.text.y = element_text(size=rel(1.3), hjust = 0.5), 
        legend.text=element_text(size=rel(1))) +
  scale_fill_manual(values=cbPalette[c(1, 2)], name = "Timepoint") +
  scale_color_manual(values=cbPalette[c(9, 8, 4)]) 

absddx4plot

ggsave("./Plots/20240131_DDX4count_abs_colororg.pdf", width=6.5, height=3)
ggsave("./Plots/20240131_DDX4count_abs_colororg.png", width=6.5, height=3)



###### Fig. 2G: 

## Volumes
p1tibnorm$Volume <- p1tibnorm$'Volume(E6_um3)'

vol.summ <- summarySE(p1tibnorm, na.rm=T, measurevar = 'Volume', groupvars = c('Prop', 'Condition', 'Organization'))

vol.summ$Condition <- factor(vol.summ$Condition, levels = c("T=0d", "T=7d"))
vol.summ$Organization <- factor(vol.summ$Organization, levels = c("Mixed", "SC out", "No org."))


volplot <- ggplot(vol.summ, aes(y=Volume, x=Prop, fill=Condition)) +
  geom_bar(position="dodge", stat = "identity") +
  geom_point(data=p1tibnorm, aes(y=Volume, x=Prop, group=Condition, color=Organization), position = position_dodge(width=0.9), size = 2.5, alpha = 0.65) +
  ylab("Volume/rhTestis (E6um3)") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(size=rel(0.9)), 
        axis.text.x = element_text(size=rel(1.1), vjust = 0.5), 
        axis.text.y = element_text(size=rel(1.3), hjust = 0.5)) +
  scale_fill_manual(values=cbPalette[c(1, 2)], name = "Timepoint") +
  scale_color_manual(values=cbPalette[c(9, 8, 4)]) 

volplot

ggsave("./Plots/20240131_Volume_colororg.pdf", width=6.5, height=3)
ggsave("./Plots/20240131_Volume_colororg.png", width=6.5, height=3)


