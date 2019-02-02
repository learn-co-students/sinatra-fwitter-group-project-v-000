class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      @user.tweets << @tweet
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @id = params[:id]
      @user_tweet = User.find(session[:user_id]).tweets.find(@id).content
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id' do
    if logged_in?
      @users_tweet = User.find(session[:user_id]).tweets.find(params[:id]).content
      @id = params[:id]
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @id = params[:id]
    if params[:content] == ""
      redirect "/tweets/#{@id}/edit"
    else
      @user_tweet = User.find(session[:user_id]).tweets.find(params[:id])
      @user_tweet.content = params[:content]
      @user_tweet.save
      redirect "/tweets/#{@id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @id = params[:id]
      @user = User.find_by_id(session[:user_id])
      if @tweet = Tweet.find_by(id: @id)
        if (@tweet.user == @user) && (@tweet == @user.tweets.find(@id))
          @tweet.destroy
          redirect '/tweets'
        end
      else
        redirect "/tweets/#{@id}"
      end
    else
      redirect '/login'
    end
  end

end
