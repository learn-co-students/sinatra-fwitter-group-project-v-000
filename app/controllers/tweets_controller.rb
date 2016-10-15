class TweetsController < ApplicationController
  get '/tweets' do
    if !session[:id].nil?
      @user = User.find_by(session[:id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !session[:id].nil?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params["tweet"]["content"].nil? || params["tweet"]["content"] == ""
      redirect '/tweets/new'
    else
      user = User.find_by(session[:id])
      tweet = Tweet.new(params["tweet"])
      user.tweets << tweet
      redirect to("/tweets/#{tweet.id}")
    end
  end

  get '/tweets/:id' do
    user = User.find_by(session[:id])
    @tweet =  Tweet.find_by(params[:id])
    if !session[:id].nil? && @tweet.user_id == user.id
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if !session[:id].nil?
      @user = User.find_by(session[:id])
    end
    if !@tweet.nil? && !@user.nil?
      if @tweet.user_id == @user.id
        erb :'/tweets/edit'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if !session[:id].nil?
      @user = User.find_by(session[:id])
    end
    tweet = Tweet.find_by(params[:id])
    if @user.id == tweet.user_id
      if !params[:tweet][:content] == "" || !params[:tweet][:content].nil?
        tweet.content = params[:tweet][:content]
        tweet.save
        redirect to("/tweets/#{tweet.id}/edit")
      else
        redirect to("/tweets/#{params[:id]}/edit")
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if !session[:id].nil? && params["Delete Tweet"]
      user = User.find_by(session[:id])
      tweet = Tweet.find_by(params[:id])
    end
    if user.id == tweet.user_id && !user.id.nil?
      tweet.destroy
    else
      redirect to("/tweets/#{params[:id]/edit}")
    end
  end

end
