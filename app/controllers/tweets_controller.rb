class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect("/login")
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      if params[:content] != ""
        erb :'tweets/create_tweet'
      else
        redirect("/tweets/new")
      end
    else
      redirect("/login")
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect("/login")
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.id == current_user.id
        erb :"/tweets/edit_tweet"
      else
        redirect("/tweets")
      end
    else
      redirect("/login")
    end
  end

  post '/tweets' do
    if is_logged_in? && params[:content] != ""
      @tweet = current_user.tweets.create(content: params[:content])
      redirect("/tweets/#{@tweet.id}")
    else
      redirect("/tweets/new")
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect("/tweets/#{@tweet.id}")
    else
      redirect("/tweets/#{@tweet.id}/edit")
    end
  end

  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if current_user.id == @tweet.user_id
        @tweet.delete
        redirect("/tweets")
      else
        redirect("/tweets")
      end
    else
      redirect("/login")
    end
  end

end
