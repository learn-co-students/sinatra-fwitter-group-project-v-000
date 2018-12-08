class TweetsController < ApplicationController

  get '/tweets' do
    # raise params.inspect
      if logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
      else
        redirect :'/login'
      end
    end

    get '/tweets/new' do
      if logged_in?
      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end

    post '/tweets' do
      #binding.pry
      if logged_in? && params[:content].empty?
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
  end
  end

end
