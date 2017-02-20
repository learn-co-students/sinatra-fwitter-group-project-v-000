class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      flash[:message] = ['Please log in to view tweets']
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @tweet = Tweet.new
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find params[:id]
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find params[:id]
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find params[:id]
    if @tweet
      @tweet.content = params[:content]
      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        flash[:message] = @tweet.errors.full_messages
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/tweets'
    end
  end

  post '/tweets' do
    @user = current_user
    if params[:content]
      @tweet = Tweet.new params
    elsif params[:tweet][:content]
      @tweet = Tweet.new params[:tweet]
    end

    if @tweet.save
      @user.tweets << @tweet
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = @tweet.errors.full_messages.uniq
      redirect '/tweets/new'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find params[:id]
    if current_user == @tweet.user
      @tweet.destroy
    end
    redirect '/tweets'
  end
end
