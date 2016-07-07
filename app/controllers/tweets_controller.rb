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
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    end
  end

  post '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login" # redirect if not logged in
    elsif params[:tweet] == ""
      erb :'/tweets/edit_tweet'
    else
      current_user.tweets.find_by(params[:id]).update(content: params[:tweet])
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do #delete action
    tweet = Tweet.find(params[:id])
    if logged_in? && tweet == current_user.tweets.find_by(params[:id])
      tweet.delete
    end
  end

end
