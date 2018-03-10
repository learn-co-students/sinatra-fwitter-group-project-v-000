class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      flash[:notice] = "Must log in to see content!"
      redirect to('/login')
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to('/login')
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(params)
    if @tweet.save
      redirect to('/tweets')
    else
      # add error message to session hash "session[:error]", then conditional to new tweet erb page
      redirect to('/tweets/new')
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      flash[:notice] = "Must log in to see content!"
      redirect to('/login')
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      erb :'tweets/edit_tweet'
    elsif logged_in?
      flash[:notice] = "Can only edit tweets you made"
      redirect to("/tweets/#{@tweet.id}")
    else
      redirect to('/login')
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])

      redirect to("/tweets/#{@tweet.id}")
    else
      redirect to("/tweets/#{@tweet.id}/edit")
    end
  end


  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by(id: params[:id])
    if tweet.user == current_user
      tweet.destroy
      redirect to("/tweets")
    else
      flash[:notice] = "Cannot delete other Users Tweets"
      redirect to("/tweets/#{tweet.id}")
    end
  end


end
