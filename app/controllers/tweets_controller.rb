class TweetsController < ApplicationController


  get '/tweets' do
    if !logged_in? || !current_user
      redirect '/login'
    else
       @current_user = User.find(session[:user_id])
    erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    if @tweet.valid?
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !current_user
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in? || !current_user
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    end
  end

  patch '/tweets/:id' do
    if !logged_in? || !current_user
      redirect "/login"
    else
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
    end
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    if !logged_in? || !current_user
      redirect "/login"
    else
      Tweet.delete(params[:id])
      redirect '/tweets'
    end
  end

end
