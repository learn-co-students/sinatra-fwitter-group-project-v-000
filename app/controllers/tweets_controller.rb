class TweetsController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get "/tweets" do
    erb :"tweets/tweets"
  end

end
