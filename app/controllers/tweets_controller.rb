class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do

    # I was getting null content by using << and couldn't understand why.
    # This is another instance where I need to do something different because
    # of the relationship of the table objects. The solution was using build.
    # I would have thought create would be the same, but the more I stare at
    # it, I think I understand why. This is a better way to enforce the relationship
    # between the objects, probably always consider using this when a has_many is
    # involved. Don't forget that this needs to be saved! It is a version of new,
    # not of create.
    if params[:content] == ""
      redirect '/tweets/new'
    else
      user = User.find(session[:user_id])
      user.tweets << Tweet.create(content: params[:content])
      # tweet = current_user.tweets.build(content: params[:content])
      # tweet.save
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

      erb :'tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do

    tweet = Tweet.find(params[:id])

    if logged_in? && params[:content] != "" && current_user.tweets.include?(tweet)

      tweet.content = params[:content]
      tweet.save

      redirect "tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do

    tweet = Tweet.find(params[:id])

    if logged_in? && current_user.tweets.include?(tweet)
      tweet.delete
    end

    redirect '/tweets'
  end

  post '/tweets/:id' do


  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'

    else
      redirect '/login'

    end
  end

end
