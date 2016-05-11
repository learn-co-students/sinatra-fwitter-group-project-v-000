class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect('/login')
    end
  end

  post '/tweets' do
    if is_logged_in?
      if !params[:tweet][:content].empty?
        @user = User.find_by(:email => session[:email])
        @tweet = @user.tweets.create(params[:tweet])
        redirect('/tweets')
      else
        redirect('/tweets/new')
      end
    else
      redirect('/login')
    end

  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect('/login')
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect('/login')
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect('/login')
    end
  end

  patch '/tweets/:id' do
    if is_logged_in?
      if !params[:tweet][:content].empty?
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:tweet])
        @tweet.save
      else
        redirect("/tweets/#{params[:id]}/edit")
      end
    else
      redirect('/login')
    end
  end

  delete '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect('/tweets')
      else
        redirect('/tweets')
      end
    else
      redirect('/login')
    end
  end

end
