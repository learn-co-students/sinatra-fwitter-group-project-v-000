class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
  if logged_in?
    erb :'tweets/create_tweet'
  else
    redirect '/login'
  end
end

  post '/tweets' do
    @user = current_user
    if params[:content] != ""
      @user.tweets << Tweet.create(content: params[:content])
      redirect "/users/#{@user.slug}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.delete
    end
    redirect '/login'
  end



end
