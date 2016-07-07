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

  post '/tweets/:id' do
    binding.pry
  end

end
