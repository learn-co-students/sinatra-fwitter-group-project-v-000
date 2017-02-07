class TweetsController < ApplicationController

  get '/tweets' do 
    if !logged_in?
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      @current_user = current_user
      erb :'tweets/create_tweet'
    end
  end

  get '/tweets/:id' do 
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])

      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/new' do 
    if !logged_in?
      redirect '/login'
    elsif params[:content] == ''
      redirect '/tweets/new'
    else
      @user = current_user
      @tweet = @user.tweets.build(content: params[:content])
      @user.save

      redirect "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do 
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do 
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end



end