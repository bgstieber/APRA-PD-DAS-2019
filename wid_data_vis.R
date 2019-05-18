library(tidyverse)
library(scales)
library(extrafont)
loadfonts()

theme_bgs <- function(){
  theme_bw() +
    theme(text = element_text(family = 'Segoe UI'),
          plot.title = element_text(face = 'plain', size = 14),
          plot.subtitle = element_text(family = 'Segoe UI Semibold'),
          panel.border = element_rect(colour = 'grey85'),
          panel.grid.minor = element_line(colour = "grey98", size = 0.25),
          axis.title = element_text(family = 'Segoe UI Semibold', size = 12),
          axis.text = element_text(size = 12),
          axis.ticks = element_blank(),
          legend.justification = 'top',
          legend.title = element_text(family = 'Segoe UI Semibold'),
          strip.background = element_rect(fill = 'grey92'),
          strip.text = element_text(family = 'Segoe UI Semibold'))
}

theme_set(theme_bgs())

ineq_data <- read_delim("WID_Data_Metadata//WID_Data_18052019-130037.csv",
                        delim = ";", 
                        skip = 8,
                        col_names = c("category",
                                      "year",
                                      "Wealth",
                                      "Income"))

cite_caption <- "Piketty, Thomas; Saez, Emmanuel and Zucman, Gabriel (2016).\nDistributional National Accounts: Methods and Estimates for the United States."

p1 <- ineq_data %>%
  gather(variable, value, Wealth, Income) %>%
  ggplot(aes(year, value, colour = variable))+
  geom_line(size = 1.2)+
  geom_point()+
  scale_y_continuous("Share of Total (%)",
                     labels = percent)+
  scale_x_continuous(breaks = seq(0, 3000, 15),
                     name = "Year")+
  scale_colour_brewer(palette = 'Set1',
                      name = "Data Point")+
  ggtitle("Rising Inequality Since 1980\nShare of Income and Wealth for Top 10% in USA")+
  labs(caption = cite_caption)+
  theme(plot.title = element_text(size = 25),
        axis.text = element_text(size = 22),
        legend.text = element_text(size = 22),
        legend.title = element_text(size = 24),
        axis.title = element_text(size = 24),
        plot.caption = element_text(size = 16))
