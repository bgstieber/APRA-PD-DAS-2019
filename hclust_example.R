library(tidyverse)
library(factoextra)

whole_sale <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/00292/Wholesale%20customers%20data.csv")

whole_sale_scale <- whole_sale %>%
  select(Fresh:Delicassen) %>%
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
                        k = 6))


aggregate(.~clust,
          data = whole_sale_scale2,
          mean)



fviz_cluster(list(data = whole_sale_scale,
                  cluster = cutree(hclust_whole_sale_ward, k = 3)))


fviz_nbclust(whole_sale_scale,
             FUN = hcut,
             method = 'wss')


