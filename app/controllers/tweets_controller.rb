class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/new"
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect "/tweets/#{@tweet.id}" if @tweet.save
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      (@tweet.user == current_user) ? (erb :'/tweets/edit_tweet') : (redirect '/tweets')
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        (@tweet.user == current_user) ? (redirect to "/tweets/#{@tweet.id}" if @tweet.update(content: params[:content])) : (redirect '/tweets')
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete if @tweet.user == current_user
    else
      redirect 'login'
    end
  end

end
