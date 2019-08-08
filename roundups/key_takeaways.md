# Key Takeaways from APRA PD 2019

- Send surveys to first time donors and long lapsed donors
    + Why did you give? What are you interested in? etc
    + Can help in marketing messaging and communication strategies
- During the keynote, there was moment for a discussion about "what do you wish your senior management knew about you and your work". Conversations lasted a long time, and covered a few common issues
    + Trust the data
    + Data is only as good as information being put into the system
    + Timing (how long it takes to produce an analytical product)
    + Definition of requirements
    + Relying on what we've done in the past is not going to get us where we want to go next
    + __My question is__: why are these problems and why do they continue to be problems? I've heard similar comments since starting at WFAA. Are analysts/researchers/data scientists helpless? What needs to be done to solve/move forward at least one of these issues? 
- Using recommender systems to identify prospect interests
    + Extremely similar to fund recommendation engine, but took it one step deeper to generate recommendations for each donor
        * Would be pretty simple to spin one up
    + Could also apply recommendations to non-donors, by matching characteristics/demographics for donors
    + Faced similar "setbacks" in deploying the results
- People are still using scorecard models, which _I guess_ is better than nothing
    + Rather than weighting values arbitrarily, we could sum up 1/0 indicators for different engagement variables. Unless we can get stakeholders to agree on the target we're trying to predict
- Segment by score, action by cell
    + LSU uses three "scores" to define 8 different segments (they create two bins for each score)
    + These segments have catchy names, qualitative descriptions, and strategy recommendations
    + Every constituent receives a "persona"
    + Devoted a lot of time and energy to deploying this analysis. They had roadshows to socialize the results and win over early champions
- People treat deploying predictive models and having them used as a success story. It shouldn't be! These things work __and__ we have data to back that up. Data scientists need to get better at understanding and explaining their work if they want to improve adoption.
- Hilary Parker keynote was really good
    + Data science is about systems engineering (data flows and its flow must be controlled through each part of the data science process)
    + Blameless postmortems: don't blame the operator, blame the system. 
        * Identify incident and record, research what others have done, and consider ROI (how much effort is improving/iterating on system worth?)
    + Data collection is an underrated part of data science - can you take efforts to improve your data quality and/or collect more?
    + Improving data science design abilities: consume and participate, purposeful practice, give your right brain space, cultivate empathy

## Things to Try

- More intentional segment by score, action by cell analyses
- Improve understanding of organizational data science needs
    + Both demand side (what do people want?) and supply side (what can we provide?)
- Reexamine fund recommendation engine and extend to constituent-level recommendations
- Investigate options of collecting more data across important areas
    + Philanthropic motivations and interests (lapsed/acquisition donor surveys)

