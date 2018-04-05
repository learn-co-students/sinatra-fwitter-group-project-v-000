class TweetsController < ApplicationController
  
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
      erb :'tweets/create_tweet'
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
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end 
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session) 
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect '/login'
    end 
  end 

  get '/tweets/:id/edit' do 
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else 
      redirect '/login'
    end
  end 

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if User.is_logged_in?(session)
      if params[:content].empty?
        flash[:notice] = "Tweet field cannot be blank!"
        redirect "/tweets/#{@tweet.id}/edit"
      elsif @tweet && @tweet.user == User.current_user(session)
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    else 
      flash[:notice] = "you cannot edit #{@tweet.user}'s content"
      redirect to '/login'
    end
  end 

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if User.is_logged_in?(session) && @tweet.user == User.current_user(session)
      @tweet.delete 
      redirect to "/tweets"
    else 
      redirect to "/tweets/#{@tweet.id}"
    end 
  end 



end