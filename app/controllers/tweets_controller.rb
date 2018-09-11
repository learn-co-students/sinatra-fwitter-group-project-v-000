class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id]
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if session[:id]
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
      @tweet = Tweet.new(content:  params[:content])
      @tweet.user_id = current_user.id
      if @tweet.save
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
  end

  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
   if session[:id]
     @tweet = Tweet.find(params[:id])
     if @tweet.user_id == current_user.id
       erb :'tweets/edit'
     else
       redirect '/tweets'
     end
   else
      redirect '/login'
   end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
     if @tweet.save
       redirect "/tweets/#{@tweet.id}"
     else
       redirect "/tweets/#{@tweet.id}/edit"
     end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
          @tweet.destroy
          redirect '/tweets'
        end
    else
      redirect '/login'
    end
  end


end
