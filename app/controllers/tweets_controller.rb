class TweetsController < ApplicationController

  get '/tweets' do
    if Helper.logged_in?(session)
      @tweets= Tweet.all
      @user = Helper.current_user(session)
      erb :'tweets/tweets'
    else
      redirect to "/login"
     end
  end

  #create
  get '/tweets/new' do
    if Helper.logged_in?(session)
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    #binding.pry
    user = Helper.current_user(session)
    if !params[:content].empty?
      @tweet= Tweet.create(content: params[:content])
      @tweet.user = user
      @tweet.save
    else
      redirect "/tweets/new"
    end
    redirect("/tweets/#{@tweet.id}")
  end

  #show
  get '/tweets/:id' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  #edit
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if Helper.logged_in?(session)
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}/edit"
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == Helper.current_user(session)
      @tweet.delete
    else
      redirect "/login"
    end
  end
end
