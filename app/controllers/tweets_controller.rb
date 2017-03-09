class TweetsController < ApplicationController

  get '/tweets/new' do # displays 'create tweet' form
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do # created tweet is submitted to database
    if params[:content] == "" # checks submission for content
      redirect to '/tweets/new' # if none found redirects user to new tweet form
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
   end
  end

  get '/tweets' do # displays information for a single tweet
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  else
    redirect to '/login'
  end
  end

  get '/tweets/:id/edit' do # load tweet edit form
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id # ensures the tweet to be edited belongs to the current_user
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do # updates tweet in database
    if params[:content] == "" # checks submission for content
      redirect to "/tweets/#{params[:id]}/edit" # if none found redirects user to edit form form for particular tweet
    else
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
    end
  end

    delete '/tweets/:id/delete' do  # form to delete a tweet (no fields / submit bttn)
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id #ensures the tweet to be *deleted* belongs to the current_user
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
