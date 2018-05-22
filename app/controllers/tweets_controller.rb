
class TweetsController < ApplicationController

  get '/tweets' do
    puts "Tweets Index Route"
    if logged_in?
      puts "Session user = #{session[:user_id]} -- Show Tweets Index"
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      puts "User Not Logged In"
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    puts "New Tweet Route"
    if logged_in?
      puts "Create New Tweet"
      erb :'/tweets/create_tweet'
    else
      puts "User Not Logged In"
      redirect to "/login"
    end
  end

  post '/tweets' do
    puts "New Tweet Params = #{params}"
    tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    redirect to "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    puts "Specific Tweet Route"
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    puts "Edit Tweet Route"
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    puts "Edit Tweet Params = #{params}"
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    puts "Delete Tweet Route"
    tweet = tweet.find(params[:id])
    tweet.delete
    redirect to '/tweets'
  end

end

# rspec spec/controllers/application_controller_spec.rb

# learn --f-f << -- only reports the first spec failure
