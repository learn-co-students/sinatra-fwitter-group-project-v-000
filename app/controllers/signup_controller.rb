class SignupController < ApplicationController

    get '/signup' do
      if !!session[:id]
        redirect '/tweets'
      else
        erb :signup
      end
    end

    post '/signup' do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = user.id
      if user.save
        redirect '/tweets'
      else
        redirect '/signup'
      end
    end

end
