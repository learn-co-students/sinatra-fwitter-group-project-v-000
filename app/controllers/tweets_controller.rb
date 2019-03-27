class TweetsController < Sinatra::Base
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/tweets' do
        erb :'tweets/tweets'
    end

end
