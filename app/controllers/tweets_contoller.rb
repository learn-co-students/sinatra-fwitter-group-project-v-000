class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
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
    if params["content"]==""
     redirect to "/tweets/new"
    else
      @tweet=Tweet.new(content: params[:content])
      @tweet.user_id=current_user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
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
