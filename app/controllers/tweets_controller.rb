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

    # show tweet creation page if logged in
    # if logged out, redirect to the login page
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/create_tweet'
        else
            redirect '/login'
        end
    end

    # submits the new tweet form
    # if the user is logged in only, if not, redirect to log in page
    # if the tweet text field is empty, redirect back to /tweets/new
    # if there is content in text area, build the tweet
    # if the tweet saves, redirect to that tweet page
    # if it doesn't save, redirect to /tweets/new form page
    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                redirect '/tweets/new'
            else
                # .build method returns a new object of the tweets that has been instantiated with content
                @tweet = current_user.tweets.build(content: params[:content])
                if @tweet.save
                    # use double quotes for correct interpolation
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect 'tweets/new'
                end
            end
        else
            redirect '/login'
        end
    end

    # if user is logged in, redirect them to the single tweet page
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

end
