class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      @user = User.find_by_id(session[:user_id])
       @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      erb :'tweets/homepage'
    else
      redirect to 'users/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :"/tweets/new"
    else
      redirect to 'users/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end


  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
       @tweet.user_id == session[:user_id]
        erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == nil
    redirect to "/tweets/#{@tweet.id}"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
          redirect to "/tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
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
