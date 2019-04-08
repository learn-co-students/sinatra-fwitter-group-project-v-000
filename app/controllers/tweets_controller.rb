class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content])
        @tweet.user_id = current_user.id
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user_id == current_user.id
        erb :"tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      if params[:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      erb :'users/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user_id == current_user.id
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
