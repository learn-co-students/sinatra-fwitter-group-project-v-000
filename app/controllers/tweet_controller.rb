class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

    get '/tweets/new' do
      if logged_in?
        @user = User.find(session[:user_id])
        erb :'/tweets/new'
      else
        redirect to '/login'
      end
    end

    post '/tweets' do
      if !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        redirect to '/tweets'
      else
        redirect to '/tweets/new'
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        @user = User.find_by(id: @tweet.user_id)

        erb :'/tweets/show'
      else
        redirect to '/login'
      end
    end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = User.find_by(id: @tweet.user_id)

      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if ((logged_in?) && (@tweet.user_id == session[:user_id]))
      @tweet.update(content: params[:content])
      @user = User.find_by(id: @tweet.user_id)

      erb :'/tweets/show'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if ((logged_in?) && (@tweet.user_id == session[:user_id]))
      @tweet.destroy
      
      erb :'/tweets/delete'
    end
  end

end
