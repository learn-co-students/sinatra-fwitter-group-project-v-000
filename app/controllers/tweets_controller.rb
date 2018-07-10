class TweetsController < ApplicationController

  get "/tweets" do 
    erb :'/tweets/tweets'
  end
  
  get "/tweets/new" do 
    erb :'/tweets/new'
  end
  
  
  post "/tweets/new" do 
  end
  
  
  get "tweets/:id" do
    erb :'/tweets/show_tweet.erb'
  end
  
  get "tweets/:id/edit" do
    erb :'/tweets/edit_tweet.erb'
  end
  
  post "tweets/:id" do
    # Youll want to create an edit link on the tweet show page.
  end
  
  
  
  post "tweets/:id/delete" do
  # The form to delete a tweet should be found on the tweet show page.
  
  # The delete form doesnt need to have any input fields, just a submit button.
  
  # The form to delete a tweet should be submitted via a POST request to tweets/:id/delete.
  end
  
  


end
