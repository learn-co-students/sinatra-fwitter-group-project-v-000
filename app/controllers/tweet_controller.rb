class TweetController < ApplicationController

  get '/tweets' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/errors/login' do
    erb :'/errors/login'
  end

  get '/errors/signup' do
    erb :'/errors/signup'
  end

  get '/errors/tweets_show' do
    erb :'/errors/tweets_show'
  end

  get '/tweets/new' do
    if !is_logged_in?
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  get '/tweets/show' do
    if !is_logged_in?
      redirect '/login'
    else
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit'
      else
        erb :'/errors/tweets/show'
      end
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    end
    if !is_logged_in?
      redirect '/user/login'
    end
    if !!@user = User.find_by(email: params[:email])
      redirect '/user/login'
    end
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    redirect "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    if params[:content] == ""
          @tweet = Tweet.find_by_id( params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    end
    if !!@user = User.find_by(email: params[:email])
      redirect '/user/login'
    end
    if !is_logged_in?
      redirect '/user/login'
    end
    @tweet = Tweet.find_by_id( params[:id])
    if @tweet.user_id == current_user.id
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      erb :'/errors/tweets/show'
    end
  end

  delete '/tweets/:id/delete' do
    if !!@user = User.find_by(email: params[:email])
      redirect '/user/login'
    end
    if !is_logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        erb :'/errors/tweets_show'
      end
    end
  end
end
