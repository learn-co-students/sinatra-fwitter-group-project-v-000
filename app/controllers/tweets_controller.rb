class TweetsController < ApplicationController

  get '/tweets' do
    if Helper.logged_in?(session)
      @tweets= Tweet.all
      @user = Helper.current_user(session)
      erb :'tweets/tweets'
    else
      redirect to "/login"
   end
    #erb :'tweets/tweets'
  end

  #create
  get '/tweets/new' do
    if Helper.logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    binding.pry
    user = Helper.current_user(session)
    @tweet= Tweet.create(content: params[:content])
    @tweet.user = user
    @tweet.save
    redirect("/tweets/#{@tweet.id}")
  end



  #show
  get '/tweets/:id' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb 'tweets/show'
    else
      redirect "/login"
    end
  end

  #edit
  get '/tweets/:id/edit' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb 'tweets/edit'
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do

  end

  #delete
  post '/tweets/:id/delete' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb 'tweets'
    else
      redirect "/login"
    end
  end

end
