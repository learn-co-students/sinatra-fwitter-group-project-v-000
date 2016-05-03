class TweetController < ApplicationController


  get '/tweets' do
    #binding.pry
    if is_logged_in 
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == "" || params[:content] == " " 
      redirect '/tweets/new'
    else
      #binding.pry
      @user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    #binding.pry
    if is_logged_in && current_user.id == @tweet.user_id 
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    #binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in && current_user.id == @tweet.user_id 
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == "" || params[:content] = " "
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.update(params)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    binding.pry
    @tweet = Tweet.find_by_id(params[:id])

    if is_logged_in && current_user.id == @tweet.user_id 
      current_user.tweets.find_by(params[:id]).destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end