class TweetsController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if  @user
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find(session[:id])
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end


  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find(session[:id])
      erb :home
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @old_tweet = Tweet.find(params[:id].to_i)
    if params[:content] != @old_tweet && !params[:content].empty?
      @old_tweet.content = params[:content]
    end
    @old_tweet.save
  end

  post '/tweets' do
    @user = User.find(session[:id])
    if !params[:content].empty?
      @user.tweets << Tweet.create(content: params[:content])
    else
      redirect '/tweets/new'
    end
    @user.save
    redirect "/tweets/#{@user.id}"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
      session[:id] = @user.id
      redirect to '/tweets'
  end



  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:id] == @tweet.user.id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end
end
