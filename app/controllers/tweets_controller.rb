class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user_id: session[:user_id])

    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      @user_id = @tweet.user_id
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @user_id = @tweet.user_id
    if Helpers.current_user(session).id.equal?(@user_id)
      Tweet.delete(params[:id])
    end
    redirect '/tweets'
  end
end
