class TweetController < ApplicationController

  get '/tweets' do
    if User.is_logged_in?(session)
      @user = User.find(session[:id])
      erb :'tweets/tweets'
    else
      redirect to("/login")
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect to("/login")
    end
  end

  post '/tweets/new' do
    flash[:err_blank_tweet] = "Oops! Your Tweet is blank. Please type in something to say." if params[:content].empty?

    if flash[:err_blank_tweet]
      redirect to("/tweets/new")
    else
      new_tweet = Tweet.create(:content => params[:content])    
      user = User.current_user(session)
      user.tweets << new_tweet
      redirect to("/tweets")
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to("/login")
    end
  end

  delete '/tweets/:id' do    
    deleted_tweet = Tweet.find(params[:id])
    if deleted_tweet.user == User.current_user(session)
      deleted_tweet.delete
      redirect to("/tweets")
    else
      redirect to("/tweets")
    end
  end

  get '/tweets/:id/edit' do
    redirect to("/login") if !User.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])

    if User.is_logged_in?(session) && @tweet.user == User.current_user(session)
      erb :'tweets/edit_tweet'
    else      
      redirect to("/login")
    end
  end

  patch '/tweets/:id/edit' do
    editted_tweet = Tweet.find(params[:id])

    flash[:err_blank_tweet] = "Oops! You tried to edit everything out." if params[:content].empty?

    if flash[:err_blank_tweet]
      redirect to("/tweets/#{editted_tweet.id}/edit")
    else
      editted_tweet.content = params[:content]
      editted_tweet.save
      redirect to("/tweets/#{editted_tweet.id}")
    end
  end




end