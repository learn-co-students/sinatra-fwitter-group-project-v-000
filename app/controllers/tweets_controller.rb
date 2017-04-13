require 'pry'
class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    #binding.pry

    if params[:content].empty?
      redirect '/tweets/new'
    else
      #binding.pry
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      redirect to "/users/#{@user.slug}"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

   get '/tweets/:id/edit' do
     if session[:user_id]
       @tweet = Tweet.all.find_by_id(params[:id])

       if @tweet.user_id == session[:user_id]
         erb :'tweets/edit_tweet'
       end

     else
       redirect to '/login'
     end
   end

   patch '/tweets/:id' do
     if params[:content].empty?
       redirect to "/tweets/#{params[:id]}/edit"
     else
       @tweet = Tweet.find_by_id(params[:id])
       @tweet.content = params[:content]
       @tweet.save
       redirect to "/tweets/#{@tweet.id}"
     end
   end

   delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])

      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      end

    else
      redirect to '/login'
    end
  end


end
