rm(list = ls())
library(osmose)
# setwd("/Volumes/007/Post_graduate/PhD/OSMOSE/ECS_OSMOSE/osmose_4.3.3_calibrar_data/osmose_4.3.3_calibrar_0411/master")

# run the osmose java core
run_osmose("ecs_all-parameters.csv",osmose="../osmose_4.3.3.jar")



##########查看模拟数据与真实数据校准情况
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(stringr)

#Biomass#

biomass_by_time_species <- read.csv('./output/ecs_biomass_Simu0.csv', skip = 1)
plot_ave <- pivot_longer(biomass_by_time_species, cols = -Time, names_to = 'Species', values_to = "biomass")

plot_ave$Time <- as.integer(plot_ave$Time)


Biomass_range <- read.csv('/Volumes/MaxNTFS/007/Post_graduate/PhD/OSMOSE/ECS_OSMOSE/Bio_osmose_base/Biomass_range.csv') %>%
  select(Latin.name, Min, Max) %>%
  rename(Species = Latin.name) %>%
  mutate(Species = str_to_title(Species), Species = str_replace_all(Species, " ", ""))

plot_ave_ <- plot_ave %>% 
  left_join(Biomass_range, by = "Species")

plot_ave_$Species <- factor(plot_ave_$Species, 
                            levels = unique(plot_ave_$Species))

plot_ave_[ , 3:5] <- (plot_ave_[ , 3:5] / 1000)


plot_ave_ <- filter(plot_ave_, Time > 19)

ggplot(plot_ave_, aes(x = Time, y = biomass)) +
  geom_rect(
    aes(
      xmin = min(Time), 
      xmax = max(Time),
      ymin = Min,
      ymax = Max
    ),
    fill = "lightblue", 
    alpha = 0.9,  # 设置透明度
    color = NA    # 无边框
  )+
  geom_line(color = "steelblue", linewidth = 0.8) +  # 绘制折线
  geom_point(color = "firebrick", size = 1) +       # 添加点（可选）
  facet_wrap(~ Species, nrow = 4, ncol = 4, scales = "free_y") +       # 4行4列布局
  scale_x_continuous(breaks = 21:50, labels = 1990:2019)+
  labs(
    title = "16 Species Biomass Change Over 30 Years",
    x = "Year",
    y = expression("Biomass (x10"^3*" ton)")) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.border = element_rect(fill = NA, color = "black"),
    # axis.line = element_line(colour = 'black'),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = "gray95", colour = 'black'),  
    strip.text = element_text(face = "italic", size = 8),
    axis.text = element_text(colour = 'black'),
    axis.ticks = element_line(colour = 'black')
  )





#Yield#

yield_by_time_species <- read.csv('./output/ecs_yield_Simu0.csv', skip = 1)


plot_ave <- pivot_longer(yield_by_time_species, cols = -Time, names_to = 'Species', values_to = "Yield")

plot_ave$Time <- as.integer(plot_ave$Time)


Yield_range <- read.csv('/Volumes/MaxNTFS/007/Post_graduate/PhD/OSMOSE/ECS_OSMOSE/Bio_osmose_base/Yield_range.csv') %>%
  select(Latin.name, Min, Max) %>%
  rename(Species = Latin.name) %>%
  mutate(Species = str_to_title(Species), Species = str_replace_all(Species, " ", ""))

plot_ave_ <- plot_ave %>% 
  left_join(Yield_range, by = "Species")

plot_ave_$Species <- factor(plot_ave_$Species, 
                            levels = unique(plot_ave_$Species))

plot_ave_[ , 3:5] <- (plot_ave_[ , 3:5] / 1000)

plot_ave_ <- filter(plot_ave_, Time > 19)

ggplot(plot_ave_, aes(x = Time, y = Yield)) +
  geom_rect(
    aes(
      xmin = min(Time), 
      xmax = max(Time),
      ymin = Min,
      ymax = Max
    ),
    fill = "lightblue", 
    alpha = 0.9,  # 设置透明度
    color = NA    # 无边框
  )+
  geom_line(color = "steelblue", linewidth = 0.8) +  # 绘制折线
  geom_point(color = "firebrick", size = 1) +       # 添加点（可选）
  facet_wrap(~ Species, nrow = 4, ncol = 4, scales = "free_y") +       # 4行4列布局
  labs(
    title = "Species Yield Change Over 50 Years",
    x = "Year",
    y = "Yield"
  ) +
  theme_minimal() +
  theme(
    axis.line = element_line(colour = 'black'),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = "gray95", colour = 'black'),  
    strip.text = element_text(face = "bold")           
  )

