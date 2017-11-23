
class TweetController < ApplicationController

  get '/tweets' do

    if !logged_in?
      redirect to '/login'
    end
    @user = User.find_by_id(session[:user_id])
    erb :'tweets/show'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if (params[:tweet][:content]).empty?
      redirect to '/tweets/new'
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(params[:tweet])
      @user.tweets << @tweet
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/show_individual_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end



  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(params[:tweet])
      redirect to '/tweets'
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(session[:user_id])
      if @tweet.user_id == @user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end


end