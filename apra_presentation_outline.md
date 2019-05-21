# APRA PD DAS 2019 Presentation Outline

APRA: Association of Professional Researchers for Advancement 

PD: Prospect Development

DAS: Data Analytics Symposium

## Preface

Brad is giving a presentation in Phoenix, AZ on Wednesday, July 31, 2019.

The title of Brad's talk is __Generating Insights from Clustering Large Donors__. This is the description of the talk:

> Stakeholders frequently ask questions like “what other donors look like this group?” or “what is the pathway to elevated giving?” Clustering techniques within the class of unsupervised learning methods let analysts generate insights into these questions for their most generous donors, even without a dependent variable they are trying to predict. 

> In this talk, the presenter will discuss a variety of clustering techniques, how and when the techniques can be applied, and how the results from clustering algorithms can be used. Segmenting an organization’s most generous donors into distinct groups can allow fundraisers, researchers, and analysts approach these important constituents in more targeted and personalized ways.

> Additionally, the presenter will comment on some of the larger trends in fundraising. These trends include the increasing concentration of giving, the continued deviation from the 80/20 Pareto principle, and the potential disruption in philanthropy caused by the ultra-wealthy.

__Learning Objective #1__:  Attendees will learn the principles for implementing and interpreting some popular unsupervised learning techniques.

How: discuss three popular algorithms, data considerations, possible interpretations, and one real-world example

__Learning Objective #2__:  Attendees will learn about the increasing influence of large donors on philanthropy, enforcing the importance of exploring data for this group.

How: Requires comparing pareto numbers over time (look at campaign contributions and WFAA donors?)

__Important Dates__:

- ~~Monday, May 20: Email draft PowerPoint to speaker liaison (assigned in March) & schedule call to discuss~~
- __Monday, June 24: All session presentations, handouts, and AV requests due__
- Thursday, July 11: Speaker Orientation Webinar
- Wednesday, July 31 - Saturday, August 3: Prospect Development 2019 in Phoenix, AZ


## Presentation Outline

The talk is scheduled for 60 minutes, which means we should present for about 45-50 minutes, and leave 10-15 minutes for questions. This works out to about 20-30 slides of content.

 - Background and Context
     + Who am I, what do I do, where do I work
         * Always important to provide context about "size of shop"
     + Large donors have always been important, but economic trends show that as wealth continues to concentrate, it's more important now than ever to learn as much as we can about this group.
  - Large Donor Disruption in Philanthropy
     + "Get real" about growing inequalities and how this affects philanthropy
     + reference the Wealth_X_World_Ultra_Wealth_Report_2018_FINAL.pdf report
     + Pareto (80/20) principle in philanthropy
         * WFAA example
         * Political giving
             - 2015-2016 for HRC, Donald Trump, and Bernie Sanders
             - https://www.fec.gov/data/browse-data/?tab=bulk-data
         * Use IRS charitable contribution data?
             - YoY?
 - __Add "spoiler" slide about what we did at WFAA, give away _some_ of the results at the beginning. Possible visual: spreadsheet arrow to four circles with clusters, how might be used__
- What is Unsupervised Learning
     + Really helpful for exploratory analysis
     + Important to know your goals when doing an analysis. It seems like we get asked for a lot of "predictions", when we're not actually trying to predict anything at all/don't have something to predict.
         * Need both X and y to build a model
 - Three Clustering Algorithms You Should Know
     + kmeans
         * Remember to scale your data!
     + hierarchical clustering
         * Agglomerative vs. divisive
         * great for exploratory, and when your data might have latent hierarchies (maybe educational breakdown?)
         * https://uc-r.github.io/hc_clustering
         * https://www.datacamp.com/community/tutorials/hierarchical-clustering-R
     + DBSCAN
         * https://medium.com/netflix-techblog/tracking-down-the-villains-outlier-detection-at-netflix-40360b31732
         * http://www.sthda.com/english/wiki/wiki.php?id_contents=7940
 - Using results from clustering
     + Relies on interpretation, and depends on your goals
 - An Example from WFAA
     + 5ish slides on Large Donor Clustering
     + Distributions: this shows what the clusters were actually doing 
     + Important to describe how it was done (what was the data?), what the results were, how to generate insights (asking better questions and paragraph summaries) and next steps
     + Implementation: visual of a "future portfolio review"

 - Wrapping Up


