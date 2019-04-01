class TweetsController < ApplicationController #ApplicationController inheritance needed for logged_in?
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/tweets' do
      if logged_in?
        erb :'tweets/tweets'
      else
        redirect to "/login"
      end
    end

    get '/tweets/new' do
      if logged_in?
        @curent_user
        erb :'tweets/new'
      else
        redirect to "/login"
      end
    end
end
