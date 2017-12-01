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
      @tweets = Tweet.all
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
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

    get '/tweets/:id' do
      if is_logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect to '/login'
      end
    end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
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

  post '/tweets/:id' do
    @tweet = Tweet.update(params)
    @tweet.save unless @tweet.content.empty?
  end

  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
