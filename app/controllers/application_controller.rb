require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "<h1>Welcome to Fwitter</h1><p><a href='/signup'>Sign Up</a></p><p><a href = '/login'>Log In</a></p>"
  end

  get '/signup' do
    if !!session[:id]
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/tweets' do
    erb :index
  end

  post '/signup' do
    binding.pry
    if !params.values.any? {|value| value.empty?}
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

end
