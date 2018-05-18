class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id] then erb :"/tweets/create_tweet" else   redirect to "/login" end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect "/tweets/new"
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if  session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id] then erb :'tweets/edit_tweet' else redirect to '/tweets' end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    while session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      #Checks to make sure the tweet's user equals the session's user if so then we delete the tweet and direct back to the tweets route
        if @tweet.user_id == session[:user_id] then @tweet.delete ; redirect "/tweets" end
        redirect "/login" #the default redirect if user not logged in
    end
  end
end
