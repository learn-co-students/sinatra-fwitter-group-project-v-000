class TweetsController < ApplicationController

  get "/tweets" do 
    if logged_in?
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end
  
  get "/tweets/new" do 
    if logged_in?
      @user = User.find(session[:id])
      erb :'/tweets/create_tweet'
    else 
      redirect '/login'
    end
  end
  
  
  post "/tweets" do 
    user = current_user
    if !params[:content].empty?
      redirect '/tweets/create_tweet'
    else
    tweet = Tweet.create(:content => params[:content], :user_id => current_user)
    redirect "/tweets"
    end
  end
  
  
  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else 
      redirect '/login'
    end
  end
  
  post "tweets/:id" do
    # Youll want to create an edit link on the tweet show page.
  end
  
  get "/tweets/:id/edit" do
    raise params.inspect
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else 
      redirect '/login'
    end
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