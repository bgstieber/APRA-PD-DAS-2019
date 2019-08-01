# Using Recommender Systems to Identify Prospect Interests - Cherry

 
## Notes 
 
- Area-of-interest model
    + Is a donor interested in a certain type of giving
    + People want more variations
        * Major giving, scholarships, capital projects
        * Too many models to manage?
    + Goal: a model that outputted probabilities of each prospect's interset in every fund
        * But 13K funds
- Used vector embeddings for each fund, translating them into an 8 value vector
    + Then did similar embedding with prospects and check similarity to find fund most interested in
    + Fund embedding didn't place similar funds next to each other
- Netflix approach: collaborative filtering
    + Netflix needs to match many users to many movies/shows, just like we need to match many prospects/donors to many funds
- Decide what you want your rows and columns to be and what should be contained within each cell
    + Rows are donors, columns are funds, cells are 1/0 based on giving (hard credit for cash in door)
        * How to handle recurring gifts? These might be too rare to worry about
- Construct a similarity measure
    + He used % similarity, kind of like  cosine similarity 
    + For each donor, take their row in the similarity matrix, and multiply each similarity % against each corresponding donor's donation value. Then add across the columns. This is the "recommendation" for each fund.
    + You can take this result, and divide by each row sum, "normalizing" the values in a way
- Model evaluation
    + Spot checked specific records
        * Model was time-insensitive to when someone was interseted in a specific fund
            - Solution: Smoothed data over time using a simple exponential smoothing model
                + Looked at data since ~1980 to calculate a final number
        * Model was insensitive to preferences of one fund over another
            - Solution: rather than using 1/0, used counts of gifts instead, then plugged that into exponential smoothing
        * Model could only build scores against prior donors
            - Lots of non-donors, how recommend/determine interests for those who haven't given
            - Solution: match non-donors to donors based on charaecteristics/demographics. Then recommend funds to these non-donors based on most similar donor(s).

 
## Key Takeaways 
 
- Unit/Site affinity model?
- Useful in marketing situations
- Included almost all data (inactive funds, sparse funds, any donor) and _then_ filtered the set of funds to recommend, rather than building the data on a pre-filtered data
- This "model" will be one of three models 
    + Likelihood to donate, likely amount of donation, likely area of donation interest
- Data and calculations
    + One row per donor, one column per fund, cells filled with some measure of giving (1/0, count, smoothed count, ...)
    + Calculate similarities between donors, adjust to be % similarity between donor X and all other donors, multiply these similarity measures across each row, column sum for donor X recommendations 

 
## Other Details / Follow Up 
 
- The ideas in this presentation were very similar to the ones from the fund recommendation engine
    + Additionally, the data team faced similar "setbacks" in deploying the results
- Could this be used for event planning/invitations?
    + What are people revealing about their preferences that we aren't offering?
