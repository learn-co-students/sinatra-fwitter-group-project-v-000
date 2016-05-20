class TweetsController < ApplicationController

    get '/tweets' do
    if session[:id]
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:id]
      @user = User.find(session[:id])
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      if session[:id] == @tweet.user_id
        erb :'tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end    
  end

  post '/tweets/new' do
    if session[:id]
      if params[:content] != ""
        @user = User.find(session[:id])
        @tweet = Tweet.create(content: params[:content], user_id: @user.id)
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to '/tweets/new'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:id] == @tweet.user_id
      if params[:content] != ""
        @tweet.content = params[:content]
        @tweet.save
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end
    redirect to "/tweets/#{@tweet.id}"
  end


  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:id] == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end

end