library(tidyverse)
library(factoextra)
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

whole_sale <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/00292/Wholesale%20customers%20data.csv") %>%
  rename("Deli" = "Delicassen")

whole_sale_scale <- whole_sale %>%
  select(Fresh:Deli) %>%
  mutate_all(log1p) %>%
  scale()

whole_scale_scale_dist <- dist(whole_sale_scale)

hclust_whole_sale_complete <- hclust(whole_scale_scale_dist)
plot(hclust_whole_sale_complete)

hclust_whole_sale_ward <- hclust(whole_scale_scale_dist,
                                   method = "ward.D")

plot(hclust_whole_sale_ward, labels = FALSE,
     main = 'Customer Clusters')
rect.hclust(hclust_whole_sale_ward, k = 6,
            border = RColorBrewer::brewer.pal(3, 'Set2'))

whole_sale_scale2 <- whole_sale_scale %>%
  as_tibble() %>%
  mutate(clust = cutree(hclust_whole_sale_ward,
                        k = 3))

aggregate(.~clust,
          data = whole_sale_scale2,
          mean)

p0 <- fviz_cluster(list(data = whole_sale_scale,
                        cluster = cutree(hclust_whole_sale_ward, k = 3)),
                   geom = "point")+
  theme_bw()


fviz_nbclust(whole_sale_scale,
             FUN = hcut,
             method = 'wss')


p1 <- fviz_dend(hclust_whole_sale_ward, 
                k = 3, 
                show_labels = FALSE, 
                lwd = 2)+
  ggtitle("Hierarchical Clustering of Wholesale Customers",
          subtitle = "Colors correspond to three unique clusters")

p1 <- p1 +
  theme_bgs()+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = 25),
        plot.subtitle = element_text(size = 22))

ggsave("whole_sale_dend.png", p1,
       width = 10, height = 6.6, units = "in", dpi = 600)

whole_sale_scale2_clust_summary <- whole_sale_scale2 %>%
  group_by(clust) %>%
  summarise_all(mean) %>%
  gather(variable, value, -clust) %>%
  mutate(largest_value = pmax(value, abs(value)))

p2 <- whole_sale_scale2_clust_summary %>%
  ggplot(aes(clust, reorder(variable, value, sd), fill = value))+
  geom_tile(colour = 'black', size = 1.2)+
  scale_fill_gradient2(low = '#0571b0', high = '#ca0020',
                       breaks = -1:1,
                       labels = c('Below', 'Average', 'Above'),
                       limits = c(-max(whole_sale_scale2_clust_summary$largest_value), 
                                  max(whole_sale_scale2_clust_summary$largest_value)),
                       name = "Spending")+
  xlab("Cluster")+
  ylab("")+
  ggtitle("Cluster Summary by Wholesale Product Categories")+
  theme(plot.title = element_text(size = 25),
        axis.text = element_text(size = 22),
        legend.text = element_text(size = 22),
        legend.title = element_text(size = 24),
        axis.title = element_text(size = 24))


ggsave("whole_sale_summary.png", p2, width = 11.69, height = 12,
       units = "in", dpi = 600)
