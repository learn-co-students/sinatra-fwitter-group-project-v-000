class TweetsController < ApplicationController

    # loads the tweet index page
    # if the user is logged in, direct them to twitter index page
    # if the user is logged out, redirect them to the login page
    get '/tweets' do
        if logged_in?
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

end
