require './config/environment'

class TweetsController < ApplicationController
  before '/tweets*' do
    check_login_status
  end

  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    if current_user.id == session[:id]
      if params[:content].strip.empty?
        redirect to '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content], user: current_user)
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    !!@tweet ? (erb :'tweets/show_tweet') : (redirect to '/tweets')
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user_id
      !!@tweet ? (erb :'tweets/edit_tweet') : (redirect to '/tweets')
    else
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id' do
    if params[:content].strip.empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && (current_user.id == @tweet.user_id)
        @tweet.content = params[:content]
        @tweet.save
      end
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end

end
