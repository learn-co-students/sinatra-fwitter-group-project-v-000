# Tweet Controller
class TweetsController < ApplicationController
  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweet/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweet/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ''
      redirect to '/tweets/new'
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # Loads the Tweet Edit Form
  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'tweet/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  # Loads a single tweet
  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweet/show_tweet'
    else
      redirect to '/login'
    end
  end

  # Edits a Tweet
  patch '/tweets/:id' do
    if params[:content] == ''
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # Delete's a Tweet
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete if @tweet.user_id == session[:user_id]
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
