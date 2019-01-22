class TweetsController < ApplicationController
    #This controlled will control all tweet actions/routes.

    get '/' do
        erb :'/index'
    end
    
    
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end
    
    post '/tweets' do
        if params[:content] == ""
          redirect :'/tweets/new'
        else
          user = User.find_by_id(session[:user_id])
          Tweet.create(content: params[:content], user_id: user.id)
        end
    
      end
    # post '/tweets' do
    #     @tweet = Tweet.create(params[:content])
    #     @tweet.save
    #     redirect to '/tweets/#{@tweet.id}'
    # end

    get '/tweets/:id' do
        if Helpers.logged_in?(session)
          @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/show_tweet'
        else
          redirect to '/login'
        end
      end
    
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end
    
end

#   #loads the signup page
# get '/signup' do
#     erb :'/users/create_user'
# end

# post '/signup' do
#     erb :'/tweets'
# end