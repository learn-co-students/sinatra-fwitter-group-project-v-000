class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do #loads tweet create form
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do #displays information for a single tweet
    if logged_in?
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do #loads form to edit
    if logged_in?
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do #processes form submission, saves to database
    @tweet.save
  end

  post '/tweets/:id' do #updates tweet entry in database
  end

  post '/tweets/:id/delete' do #loads delete form(just a submit button) on show page
  end
end
