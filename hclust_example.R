library(tidyverse)

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
plot(hclust_whole_sale_ward)

whole_sale_scale2 <- whole_sale_scale %>%
  as_tibble() %>%
  mutate(clust = cutree(hclust_whole_sale_ward,
                        k = 6))
