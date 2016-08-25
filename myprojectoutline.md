Fwitter Project Outline -  A developer check/reference list (of sorts)


I. Build out file structure/scaffold
   A.controller 
     
   B.models
    1.User 
      a)has many tweets -x
    2.Tweets 
      a)belongs to a user -x       
   C.views
    1.User  -x
     a)create user -x
     c)login -x
    
    2.Tweets -x
     a)edit -x
     b)index -x
     c)new -x
     d)edit -x

*****SAVE YOUR PROGRESS PLEASE THANK YYYYYOUUUU*****

II. Create Tables
    A.CreateUser -x
     1.username-x
     2.email-x
     3.password-x
     
    B.CreateTweets -x
     1.content -x
     2.user ids -x

****TEST OUT YOUR DATABASE PRIOR TO SAVING HERE *****
*****SAVE YOUR PROGRESS PLEASE THANK YYYYYOUUUU*****

III. Migrate! -x

*****SAVE YOUR PROGRESS PLEASE THANK YYYYYOUUUU*****

IV. Build out Controller Routes
    A.Tweet
     1.edit 
      a)gets edit form and sends to user
      b)allows user to delete from indexed tweets
      c)posts changed form & redirects to show page
     2.index - gets list of tweets
      a)lists index of tweets for user and sends back to index erb
      b)link to allow user to write a new tweet
     3.new
      a)gets new tweet form via new.erb
      b)posts new data(content) and redirects to tweets/new erb
     4.show
      a)shows data(content) of new tweet
      b)shows edited data(content) of a selected tweet.

      
    