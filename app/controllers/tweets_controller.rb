class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end
  
  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end
  
  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end
  
  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if current_user.id == @tweet.user_id
        if !params[:content].empty?
          @tweet.update(content: params[:content])
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end
  
  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if current_user.id == @tweet.user_id
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
  end
end
