library(DBI)
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

research_prod <- dbConnect(odbc::odbc(), 'RDW_prod_research')

irs_data <-dbGetQuery(research_prod, "SELECT
ZIPCODE,
'2011' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2011_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE

UNION

SELECT
ZIPCODE,
'2012' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2012_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE

UNION

SELECT
ZIPCODE,
'2013' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2013_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE

UNION

SELECT
ZIPCODE,
'2014' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2014_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE

UNION

SELECT
ZIPCODE,
'2015' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2015_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE

union 

SELECT
ZIPCODE,
'2016' IRS_Year,
SUM(A19700) SumContributionsInZip
FROM A_Data.IRS_Returns_2016_ZIP
WHERE ZIPCODE NOT IN ('00000', '99999')
GROUP BY ZIPCODE
")


irs_data <- irs_data %>%
  group_by(ZIPCODE) %>%
  spread(IRS_Year, SumContributionsInZip, fill = 0) %>%
  gather(IRS_Year, SumContributionsInZip, -ZIPCODE) %>%
  ungroup() 


irs_data2 <- irs_data %>%
  arrange(desc(SumContributionsInZip)) %>%
  group_by(IRS_Year) %>%
  mutate(cumu_perc_contrib = 
           cumsum(SumContributionsInZip) / sum(SumContributionsInZip),
         cumu_perc_obs = row_number() / n())


irs_data2 %>%
  slice(which.min(abs(cumu_perc_contrib - 0.8))) %>%
  ggplot(aes(IRS_Year, cumu_perc_obs))+
  geom_col(colour = 'black', fill = '#c5050c')+
  geom_hline(aes(yintercept = 0.2), colour = 'black', size = 1.2,
             linetype = 'dashed')+
  ggtitle("IRS Contributions Have Fallen Below Pareto 80/20 Since 2012")+
  scale_y_continuous(labels = percent,
                     name = '% of Top ZIPs Accounting for 80% of Contributions')+
  xlab('Year')

# percent change in cumulative % of obs to reach 80% of contributions
irs_data2 %>%
  slice(which.min(abs(cumu_perc_contrib - 0.8))) %>%
  ungroup() %>%
  mutate(perc_change = (cumu_perc_obs - lag(cumu_perc_obs)) / lag(cumu_perc_obs)) %>%
  filter(!is.na(perc_change)) %>%
  ggplot(aes(IRS_Year, perc_change))+
  geom_col(colour = 'black', fill = '#c5050c')+
  scale_y_continuous(labels = percent,
                     '% YoY Change in Percent of ZIPs Needed to hit 80% of Contributions')+
  ggtitle('IRS Contributions Have Continued to Get More Concentrated')+
  xlab("Year")
  

