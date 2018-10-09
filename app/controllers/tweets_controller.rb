class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/users/login'
    else
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end


  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to 'tweets/new'
      else
        @tweet = current_user.tweets.build(content: params[:content])
        @tweet.save
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect '/tweets/new'
        end
      end
    else
      redirect "/login"
    end
  end



  post '/tweets/new' do
    #binding.pry
    #if !params[:content] == ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    #else
    #  redirect :'tweets/new'
    #end
      erb :'tweets/tweets'
  end

end
