class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content]
        @tweet = Tweet.create(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end


end
