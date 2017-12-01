class TweetsController < ApplicationController

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user.id
      @tweet.save
    else
      redirect to '/tweets/new'
    end

  end

    get '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if is_logged_in? && @tweet.user_id == current_user.id
        erb :'/tweets/show_tweet'
      elsif !is_logged_in?
        redirect to '/login'
      else
        redirect to '/tweets'
      end
    end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in?
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.update(:content => params[:content])
    if !@tweet.content.empty?
      @tweet.save
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/show_tweet'
    elsif !is_logged_in?
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end
end
