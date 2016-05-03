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
    @tweet = Tweet.find_by(params[:id])
    if is_logged_in #&& current_user.id == @tweet.user_id 
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    
    if is_logged_in #&& current_user.id == @tweet.user_id 
      #binding.pry
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == is_logged_in
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else 
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    #binding.pry
    @tweet= Tweet.find_by_id(params[:id])
    if params[:content] == "" || params[:content] = " "
     redirect "/tweets/#{params[:id]}/edit"
    else
    #if is_logged_in
      @tweet.update(params[:content])
      redirect to "/tweets/#{@tweet.id}"
    ##else
     # redirect to "/login"
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