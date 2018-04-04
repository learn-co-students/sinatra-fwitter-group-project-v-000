class TweetController < ApplicationController
  
  get '/tweets' do
    if User.is_logged_in?(session)
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all 
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end 

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else 
      redirect to '/login'
    end 
  end 

  post '/tweets' do
    if params[:content].empty?
      flash[:message] ="Provide some content to post a tweet!"
      redirect to '/tweets/new'
    elsif User.is_logged_in?(session)
      @user = User.find_by(id: session[:user_id])
      @tweet =Tweet.create(params)
      @user.tweets << @tweet 
      @user.save 
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end 
  end

    get '/tweets/:id' do
      if User.is_logged_in?(session) 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
      else 
        redirect '/login'
      end 
    end 


end