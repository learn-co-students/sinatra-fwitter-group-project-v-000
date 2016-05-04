class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in 
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == "" || params[:content] == " " 
      redirect to '/tweets/new'
    else
      @user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    #binding.pry
    
    if is_logged_in #&& current_user.id == @tweet.user_id 
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if is_logged_in && current_user.id 
       @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else 
      redirect to '/login'
    end
  end

  put '/tweets/:id' do
    if is_logged_in
      #binding.pry
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if is_logged_in && current_user.id == @tweet.user_id 
      current_user.tweets.find_by(params[:id]).destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end