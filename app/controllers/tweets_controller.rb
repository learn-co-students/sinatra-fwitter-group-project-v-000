class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = current_user.tweets.create(content: params[:content])
      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content].empty?
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
      end
    else
      redirect to "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if tweet && tweet.destroy
        redirect "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

end
