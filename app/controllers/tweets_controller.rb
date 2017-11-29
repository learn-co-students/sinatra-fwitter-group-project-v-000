class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect to '/login'
    end

  end


  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect to '/login'
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.new
      tweet.content = params[:content]
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end

  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit"
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
      @tweet.content = params[:content]
      @tweet.save
      erb :"tweets/show"
      end
    else
      redirect to '/login'
    end
  end



end
