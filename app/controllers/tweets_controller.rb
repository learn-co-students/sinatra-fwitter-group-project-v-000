class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    if logged_in?
    erb :'/tweets/create_tweet'
  end
  end

  post '/tweets' do  #create tweet
  #  binding.pry
    @user = User.find_by( session[:user_id])
    @tweet = Tweet.create(content: params[:content], username: @user.username)
   redirect "/tweets/#{@tweet.id}"
end

  get '/tweets/:id' do #find/show

    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do #loads edit page
    binding.pry
    if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/edit_tweet'
  else
    redirect '/login'
    end
  end

  post 'tweet/:id' do
  #  binding.pry
    tweet = Tweet.update(content: params[:content])
    redirect '/tweets/:id'
  end

  get '/tweets' do
  #  binding.pry
    if logged_in?
    @user = User.find_by(id: session[:user_id])
    erb:'/tweets/tweets'
  else
    redirect '/login'
    end
  end
end
