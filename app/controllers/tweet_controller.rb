require './config/environment'
require 'rack-flash'

class TweetController < ApplicationController
  use Rack::Flash
    get '/tweets' do
#binding.pry
        if logged_in?
        #  binding.pry
            @user=current_user
            @alltweets = Tweet.all
            erb :'/tweets/tweets'
#binding.pry
        else
            redirect to "/login"
        end
    end
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/create_tweet'
        else
            redirect '/login'
        end

    end
    post '/tweets' do

            if params[:content] == ""
                  flash[:message] = "Tweets may not be left blank."
                  redirect "/tweets/new"
            else

                  @tweet = Tweet.create(content: params[:content], user_id: current_user[:id])
                  current_user.tweets << @tweet
                  @user = current_user
        #    binding.pry
                  redirect "/tweets/#{@tweet.id}"
              end
    end
    get '/tweets/:id' do
#binding.pry
          if logged_in?
                  @user = current_user
                  @tweet = Tweet.find_by(id: params[:id])
  #      binding.pry
                  erb :'tweets/show_tweet'
          else
                  redirect '/login'
          end
    end
    delete '/tweets/:id' do
#binding.pry
          @user = current_user
          @tweet = Tweet.find_by(id: params[:id])
          if @user.id == @tweet.user_id
            Tweet.delete(params[:id])
            redirect to("/users/#{@user.slug}")
          else
            flash[:message] = "You cannot delete a tweet that you did not create."
            redirect "/tweets/#{@tweet.id}"
          end



    end
    get '/tweets/:id/edit' do
#binding.pry
          if logged_in?
                  @user = current_user
                  @tweet = Tweet.find_by(id: params[:id])
                  erb :'/tweets/edit_tweet'
          else
                  redirect '/login'
          end
    end

  patch '/tweets/:id' do
#binding.pry

    @tweet = Tweet.find_by(id: params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    flash[:message] = "Successfully updated tweet."
    redirect "/tweets/#{@tweet.id}/edit"
  end



end


# =>        rspec spec/controllers/application_controller_spec.rb
# =>        rspec spec/models/user_spec.rb
