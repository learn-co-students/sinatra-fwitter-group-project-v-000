class UsersController < Sinatra::Base
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.create(params['user'])
        redirect to ("/tweets")
    end

end
