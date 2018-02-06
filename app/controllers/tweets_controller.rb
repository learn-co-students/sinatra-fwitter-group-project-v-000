class TweetsController < ApplicationController

#TWEET INDEX
  get '/tweets' do
    #binding.pry
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end
# CREATE TWEET
  get '/tweets/new' do
    #binding.pry
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params.empty? && params["content"]!= ""
      @tweet = Tweet.create(:content => params["content"], :user_id => "#{current_user.id}")
    else
      redirect '/tweets/new'
    end
    redirect "/tweets/#{@tweet.id}"
  end
# SHOW TWEET
  get '/tweets/:id' do
    if logged_in?
      id = params[:id].to_i
      @tweet = Tweet.find(id)
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

# EDIT TWEET
  get '/tweets/:id/edit' do
    #binding.pry
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    #binding.pry
  end
# DELETE TWEET
  delete '/tweets/:id/delete' do
    #binding.pry
  end
end
