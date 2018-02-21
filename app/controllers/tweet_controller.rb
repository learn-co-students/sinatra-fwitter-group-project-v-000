class TweetController < ApplicationController

  get '/tweets' do
    @user = User.find_by(id: session[:user_id])
    
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    @tweet = Tweet.find_by(content: params[:content])

    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user: current_user)

    if @tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = current_user.tweets.find_by(id: params[:id])

    if @tweet && @tweet.update(content: params[:content])
      redirect to '/tweets'
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/delete' do
    @tweet = current_user.tweets.find_by(id: params[:id])

    if @tweet && logged_in?
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
