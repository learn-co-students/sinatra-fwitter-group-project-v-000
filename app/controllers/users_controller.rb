class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if params.has_value?("") #if parameters have a value of ""
      redirect to '/signup' # redirect them to signup
    else # otherwise
      User.create(params) # have them create a new account
    end
    redirect to '/tweets' # no matter what, redirect them all to teh tweets
  end

end
