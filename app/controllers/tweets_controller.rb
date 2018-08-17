class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets=Tweet.all
    erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    @user=User.find_by_id(params[:user_id])
    @tweet = Tweet.new(content: params[:content])
    #  @tweet = current_user.tweets.build(content: params[:content])
    if @tweet.valid?
      @tweet.user=@user
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    tweet = Tweet.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    elsif tweet.user == current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    user = tweet.user
    if current_user.id ==user.id
      tweet.destroy
      redirect "/users/#{user.slug}"
    else
      redirect '/tweets'
    end
  end
end
