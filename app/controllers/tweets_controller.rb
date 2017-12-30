class TweetsController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect("/login")
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect("/tweets/new")
    else
      @tweet = Tweet.new(content: params[:content])
      @user = current_user
      @tweet.user_id = @user.id
      @tweet.save
      redirect("/tweets")
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect("/login")
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect("/login")
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect("/login")
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect("/tweets/#{@tweet.id}/edit")
    else
      @tweet.update(content: params[:content])
      @user = current_user
      @tweet.user_id = @user.id
      @tweet.save
      redirect("/tweets/#{@tweet.id}")
    end
  end

  post '/tweets/:id/delete' do
    if !logged_in?
      redirect("/login")
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect("/tweets")
      end
    end
  end

end
