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
      erb :'/tweets/create_tweet'
    else 
      redirect '/login'
    end
  end
  
  post "/tweets" do 
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect "/tweets"
    else
      redirect '/tweets/new'
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
  
  get "/tweets/:id/edit" do
    if logged_in? 
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else 
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    if !params[:content].empty? 
      tweet = Tweet.find(params[:id])
      tweet.update(:content => params[:content])
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end
  
  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect 'login'
    end
    
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.destroy
    end
      redirect '/tweets'
  end

end