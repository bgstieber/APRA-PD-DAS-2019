library(tidyverse)
library(DBI)

prod_conn <- dbConnect(odbc::odbc(), 'prod_dataview')

hh_recog <- dbGetQuery(prod_conn, "
-- (18, 17, 16), (15, 14, 13), (12, 11, 10), (09, 08, 07), (06, 05, 04)
SELECT
hh_sub.Household_SK,
IIF(hh_sub.CalendarYear >= 2016, '2016-2018',
IIF(hh_sub.CalendarYear >= 2013, '2013-2015',
IIF(hh_sub.CalendarYear >= 2010, '2010-2012',
IIF(hh_sub.CalendarYear >= 2007, '2007-2009', '2004-2006')))) CalendarYearGroup,
SUM(hh_sub.SumRecognition) SumRecognition
FROM (
SELECT
Household_SK,
dd.CalendarYear,
SUM(gbd.RecognitionAmount) SumRecognition
FROM bi.V_GivingBreakdownDetails gbd
INNER JOIN dw.Date_Dim dd
ON dd.Date_SK = gbd.RecognitionEffectiveDate_SK
WHERE gbd.NewCommitmentFlag = 'Y' AND gbd.ConstituentType = 'Individual' AND
dd.CalendarYear BETWEEN  2004 AND 2018
GROUP BY gbd.Household_SK,
         dd.CalendarYear
) hh_sub
GROUP BY IIF(hh_sub.CalendarYear >= 2016,
         '2016-2018',
         IIF(hh_sub.CalendarYear >= 2013,
         '2013-2015',
         IIF(hh_sub.CalendarYear >= 2010, '2010-2012', IIF(hh_sub.CalendarYear >= 2007, '2007-2009', '2004-2006')))),
         hh_sub.Household_SK
")

eighty_and_ninety <- hh_recog %>%
	arrange(desc(SumRecognition)) %>%
	group_by(CalendarYearGroup) %>%
	mutate(cumu_perc_recog = cumsum(SumRecognition) / sum(SumRecognition),
		 cumu_perc_obs = row_number() / n()) %>%
	slice(which.min(abs(cumu_perc_recog - 0.9))) %>%
	bind_rows(
	hh_recog %>%
	arrange(desc(SumRecognition)) %>%
	group_by(CalendarYearGroup) %>%
	mutate(cumu_perc_recog = cumsum(SumRecognition) / sum(SumRecognition),
		 cumu_perc_obs = row_number() / n()) %>%
	slice(which.min(abs(cumu_perc_recog - 0.8)))
)

 ggplot(eighty_and_ninety, 
		aes(CalendarYearGroup, 
		    cumu_perc_obs, 
		    fill = factor(round(cumu_perc_recog, 1))))+
	geom_col(colour = 'black', position = 'dodge')+
  scale_y_continuous(labels = percent)
 