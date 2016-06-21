class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      @user = User.find_by(session[:email])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].nil?
      redirect "/tweets/new"
    else
      # binding.pry
      @tweet = Tweet.create(params)
      @tweet.user_id = session[:id]
      @tweet.save
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    if !logged_in?
      redirect "/login"
    else
      if @tweet = current_user.tweets.find_by_id(params[:id])
        erb :"/tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params)

    redirect ("tweets/#{@tweet.id}")
  end


   delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if !logged_in?
      redirect "/login"
    else
      if @tweet = current_user.tweets.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
      else
        redirect "/tweets"
      end
    end
  end

end
