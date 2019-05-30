class TweetsController < ApplicationController

<<<<<<< HEAD
  get "/tweets" do
    if logged_in?
=======
  get '/tweets' do
    # binding.pry
    if logged_in?
      @tweets = Tweet.all
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
<<<<<<< HEAD
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      erb :'/tweets/show_tweet'
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
=======
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.new(content: params[:content], user_id: current_user.id)

      @tweet.save
      erb :"/tweets/show_tweet"
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
<<<<<<< HEAD
      if !params[:content].empty? && current_user.tweets.include?(@tweet)
        @tweet.update(content: params[:content])
=======
      if !params[:content].empty? && current_user.id == @tweet.user_id
        @tweet.update(params[:content])
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
        erb :'/tweets/show_tweet'
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
<<<<<<< HEAD
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
        @tweet.delete
        redirect "/tweets"
    else
      redirect "/login"
    end
  end


  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    erb :"tweets/index"
  end
=======
      redirect 'login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do

  end

  # get '/tweets' do
  # end

>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118

end
