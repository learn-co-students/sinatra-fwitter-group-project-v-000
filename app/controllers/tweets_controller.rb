class TweetsController < ApplicationController
  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.new(content: params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    if params[:content] != ""
      tweet.content = params[:content]
      tweet.save
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by(id: params[:id])
    if tweet.user_id == session[:user_id]
      tweet.delete
    else
      redirect to '/login'
    end
  end

end
