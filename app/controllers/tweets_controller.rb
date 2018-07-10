class TweetsController < ApplicationController

  get "/tweets" do 
    erb :'/tweets/tweets'
  end
  
  get "/tweets/new" do 
    erb :'/tweets/create_tweet'
  end
  
  
  post "/tweets" do 
    user = current_user
    tweet = Tweet.create(:content => params[:content], :user_id => current_user)
    redirect "/tweets"
  end
  
  
  get "tweets/:id" do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end
  
  get "tweets/:id/edit" do
    erb :'/tweets/edit_tweet'
  end
  
  post "tweets/:id" do
    # Youll want to create an edit link on the tweet show page.
  end
  
  
  
  post "tweets/:id/delete" do
  # The form to delete a tweet should be found on the tweet show page.
  
  # The delete form doesnt need to have any input fields, just a submit button.
  
  # The form to delete a tweet should be submitted via a POST request to tweets/:id/delete.
  end
  
   def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end


end