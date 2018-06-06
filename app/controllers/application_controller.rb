require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/figures' do
  @tweets = Tweet.all
  @users = User.all
  # model name followed by a method
  erb :'/index'
end

end
