class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

    get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params["content"].empty?
        redirect '/tweets/new'
      end
      @tweet=Tweet.new(content: params["content"])
      @tweet.user_id=session[:id]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do

    if logged_in?
      @tweet=Tweet.find(params[:id])
      # @user=User.find(@tweet.user_id)
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do

    if logged_in?
      @tweet=Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do

    @tweet=Tweet.find(params[:id])
    if params["content"].empty?

      redirect "/tweets/#{params[:id]}/edit"
    elsif logged_in? && session[:id]==@tweet.user_id
      @tweet.content=params["content"]
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/login"
    end

  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet=Tweet.find(params[:id])
      if @tweet.user_id==session[:id]
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end

  end

end
