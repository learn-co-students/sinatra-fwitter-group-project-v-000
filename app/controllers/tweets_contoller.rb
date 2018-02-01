class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets=Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content]==""
        redirect to "/tweets/new"
      else
        @tweet=Tweet.new(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
      if logged_in?
        @tweet=Tweet.find_by(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end


  end
