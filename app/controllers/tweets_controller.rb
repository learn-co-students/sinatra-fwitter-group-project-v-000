class TweetsController < ApplicationController

#shows tweets index page, showing all tweets
  get '/tweets' do
    if logged_in? #if user is logged in, show all tweets in database via index view
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login' #if user is not logged in, show login page
    end
  end

#show form to create new tweet
  get '/tweets/new' do
    if logged_in?  #if logged in, show the new tweet form via new view
      erb :'tweets/new'
    else
      redirect '/login' #if not logged in, show login screen
    end
  end

  #show a specific tweet given its ID
    get '/tweets/:id' do
      if logged_in? #if logged in...
        @tweet = Tweet.find_by_id(params[:id]) #find specific tweet by ID and assign to @tweet
        erb :'/tweets/show' #show content in @tweet via show view
      else
        redirect '/login'
      end
    end

#process new tweet form submission based on params
  post '/tweets' do
    if logged_in? #if logged in...
      if !params[:content].empty? #and if tweet_content isn't empty...
        @tweet = current_user.tweets.build(params) #create new tweet instance via #build
        @tweet.save #save new tweet instance to database
          redirect "/tweets/#{@tweet.id}" #get taken to the tweet's page
      else
        redirect '/tweets/new' #if tweet content is empty, go back to new tweet form page
      end
    else
      redirect '/login' #if not logged in, go to login page
    end
  end

#show edit tweet page for a specific tweet
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        erb :'tweets/edit'
      end
    else
      redirect '/login' #if user isn't logged in, send them to login page
    end
  end

#update the just-edited tweet
  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if !params[:content].empty? #if some content was entered in the form...
        if @tweet.user == current_user #and if the @tweet's user is also the current_user
          #binding.pry
          @tweet.update(:content => params[:content]) #update @tweet with its new content
          #@tweet.save
          redirect "/tweets/#{@tweet.id}" #send user to the tweet's own page
        end
      else #if the content field in the edit form is empty...
        redirect "/tweets/#{@tweet.id}/edit" #show the edit form again
      end
    else
      redirect '/login' #send user to login page if not logged in already
    end
  end

#delete a specific tweet given its ID
  delete '/tweets/:id/delete' do
    if logged_in? #if logged in...
      @tweet = Tweet.find_by_id(params[:id]) #assign @tweet to the specific tweet to be deleted
      if @tweet && @tweet.user == current_user #if the user of @tweet is also the current_user...
        @tweet.delete #delete the tweet
        redirect '/tweets' #and then redirect user to the tweets index
      else #if the user of @tweet does not equal current user (the user noted in the session hash)
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
end
