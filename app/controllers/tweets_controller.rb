class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
        erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
        erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweet' do
    if logged_in? && params[:tweet] != ""
      tweet = Tweet.new(content: params[:tweet])
      tweet.user_id = @current_user.id
      tweet.save
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id].to_i)
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end



  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login" # redirect if not logged in
    else
      if tweet = current_user.tweets.find_by(params[:id])
        "An edit new post form #{current_user.id} "
      else
        redirect '/tweets'
      end
    end
  end

  get '/tweets/:id/delete' do
    if !logged_in?
      redirect "/login" # redirect if not logged in
    else
      if tweet = current_user.tweets.find_by(params[:id])
        "An edit new post form #{current_user.id} "
      else
        redirect '/tweets'
      end
    end
  end

end
