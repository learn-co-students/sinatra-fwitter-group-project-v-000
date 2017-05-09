class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.create(params)

      if @tweet.save
        current_user.tweets << @tweet

        flash[:notice] = "Successfully posted a new tweet."

        redirect '/tweets'
      else
        flash[:error] = @tweet.errors.full_messages
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user

      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      
      if @tweet.user == current_user
        erb :'/tweets/edit'
      else
        flash[:notice] = "You are not authorized to edit that tweet."

        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if @tweet.user == current_user
      @tweet.content = params[:content]
      @tweet.save

      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        flash[:error] = @tweet.errors.full_messages
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      flash[:notice] = "You are not authorized to edit that tweet."

      redirect '/tweets'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    else
      flash[:notice] = "You are not authorized to edit that tweet."
    end
    redirect '/tweets'
  end

end
