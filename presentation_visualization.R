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


dd <- tibble(
  section = c('Background', 
              'Large\nDonor\nDisruption',
              'Unsupervised\nLearning',
              'Clustering', 
              'WFAA Example',
              'Wrapping Up'),
  time = c(1, 
           1.8, 
           3, 
           4, 
           5, 
           6),
  
  level = c(1, 
            1.5,
            2.25, 
            3.5, 
            2.5,
            1)
)


p1 <- dd %>%
  ggplot(aes(time, level, label = section))+
  geom_label(family = 'Segoe UI', size = 8,
             fill = 'dodgerblue3',alpha = 0.3,
             label.padding = unit(0.1, "lines"))+
  scale_y_continuous(limits = c(0,4.5), breaks = c(0.5, 2.5, 4), 
                     labels = c('low', 'medium', 'high'),
                     name = 'Techinical Level')+
  scale_x_continuous(limits = c(0, 7),
                     breaks = c(0.5, 3.5, 6.5),
                     labels = c('Beginning', 'Middle', 'End'),
                     name = 'Presentation Order')+
  theme(axis.text = element_text(size = 22),
        axis.title = element_text(size = 26),
        plot.title = element_text(size = 28))+
  ggtitle('A Visualization of this Presentation')


ggsave("presentation_vis.png", plot = p1, units = 'in',
       width = 2.5 * 4.6, height = 2.5 * 3.9, dpi = 800)

