class UserController < ApplicationController

    get '/signupnow' do
      erb :'users/create_user'
    end

    post '/signup' do
      #TO DO in this route:
      #Instantiate User info by going into pry and working with params!

      # raise params.inspect
      redirect to "tweets/tweets"
    end

end
