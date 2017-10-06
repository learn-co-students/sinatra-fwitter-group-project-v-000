class TweetsController < ApplicationController
  get '/tweets' do # route is a GET request to localhost:9393/tweets, where we see tweets index page
    if logged_in?
      @all_tweets = Tweet.all
      erb :'tweets/tweets' # render the tweets.erb view file, which is within the tweets/ subfolder within the views/ folder
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do # route is GET request to localhost:9393/tweets/new, where user sees form to create a new tweet
    if logged_in?
      erb :'tweets/create_tweet' # render the create_tweet.erb view file, which is found in the tweets/ subfolder in the views/ folder
    else
      redirect to '/login'
    end
  end

  post '/tweets' do # route receives POST request sent by submitted form to create a new tweet. Route receives data submitted in form to create a new tweet
    if params[:content] != "" # if the user did NOT leave the content field blank in the form to create new tweet, i.e., value is NOT empty string,
      @tweet = current_user.tweets.create(content: params[:content]) # create a tweet instance with its @content attribute set that automatically belongs to the user instance currently logged in and is saved to DB
      redirect to "/tweets/#{@tweet.id}" # redirect to the show page of the tweet just created
    else # otherwise, if the user left the content form field blank in form to create new tweet,
      redirect to "/tweets/new" # user will view the form to try creating a new tweet once again
    end
  end

  get '/tweets/:id' do # route is GET request to localhost:9393/tweets/@id of tweet instance (which = params[:id]) replaces :id route variable here
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id]) # find tweet instance by its @id attribute value (which was entered into URL to replace :id route variable)
      erb :'tweets/show_tweet' # render the show_tweet.erb view file, which is found within the tweets/ subfolder within the views/ folder
    else # if the user is NOT logged in, they cannot view the show page of a single tweet
      redirect to '/login' # redirect to login page where user can fill out and submit login form
    end
  end

  get '/tweets/:id/edit' do # route is GET request to localhost:9393/tweets/@id of whatever tweet instance user wants to edit replaces :id route variable here/edit
    @tweet = Tweet.find_by(id: params[:id]) # find the tweet instance by its @id value, which = params[:id]

    if !logged_in? # bar someone who's not logged in from viewing the edit form; redirect to login page
      redirect to '/login'
    elsif current_user.tweets.include?(@tweet) # Calling #current_user will return the user instance who's currently logged in. If the tweet instance requested to edit belongs to the user instance who's currently logged in (i.e. the tweet instance is included in logged in user instance's array of tweet instances belonging to it),
      erb :'tweets/edit_tweet' # render the edit_tweet.erb view file, which is found in the tweets/ subfolder within the views/ folder
    else # otherwise, if a user who IS logged in tries to access the edit form of a tweet that does NOT belong to them
      redirect to '/tweets' # redirect logged in user to the tweets index page
    end
  end

  patch '/tweets/:id' do # route is PATCH request to localhost:9393/tweets/@id of tweet instance being edited. Route receives data submitted in form to edit tweet
    @tweet = Tweet.find_by(id: params[:id])
    # When user submits edit form, whatever was entered into content field = params[:content].
    if params[:content] != "" # If the content field was NOT left blank (i.e. NOT empty string value)
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}" # redirect to the show page of the tweet we just edited
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do # route receives data when Delete Tweet button is clicked on the show page of the tweet wished to be deleted
    if logged_in? # if the user is logged in, find the tweet instance by its @id attribute value = params[:id] = what replaces :id route variable in URL localhost:9393/tweets/@id-value-of-tweet-replaces-:id-here/delete
      @tweet = Tweet.find_by(id: params[:id])
      # calling #current_user returns the user instance that is currently logged in, and then calling #tweets on it returns the array of tweet instances belonging to the logged-in user instance
      if current_user.tweets.include?(@tweet) # if the tweet belongs to the logged-in user who is trying to delete it, i.e. this tweet instance is included in array of tweet instances belonging to the user instance,
        @tweet.delete # delete the tweet instance
        redirect to '/tweets' # then redirect to the tweets index page
      else # however, if the tweet instance does NOT belong to the currently logged-in user instance who wishes to delete it,
        redirect to '/tweets' # redirect the user to the tweets index page (user does NOT get to delete tweet)
      end
    end

    redirect to '/login' # If the user requesting to delete a tweet was NOT logged in at all, redirect them to the login page
  end

end
