class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"views/tweets/tweets"
     else
       redirect to "/login"
     end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'views/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/new/tweet' do
    if !params[:tweet][:content].blank?
      tweet =Tweet.create(params[:tweet])
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'views/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get 'delete/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect to '/tweets'
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'views/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '' do
    if !params[:tweet][:content].blank?
      @tweet= Tweet.find(params[:id])
      @tweet.update(params[:tweet])
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

end
