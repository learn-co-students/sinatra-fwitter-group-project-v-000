class TweetsController < ApplicationController

#TWEET INDEX
  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end
# CREATE TWEET
  get '/tweets/new' do
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
    if logged_in?
      id = params[:id].to_i
      @tweet = Tweet.find(id)
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] && params[:content] != ""
      edited_tweet = {:content => params[:content]}
      @tweet = Tweet.find(params[:id])
      @tweet.update(edited_tweet)
      @tweet.save
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end
# DELETE TWEET
  delete '/tweets/:id/delete' do
    #binding.pry
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      current_user.id == @tweet.user_id ? @tweet.delete : return
      erb :'/tweets/deleted'
    end
  end
end
