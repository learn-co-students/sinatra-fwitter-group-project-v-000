require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

get '/' do
end


get '/new'do
end



post '/' do
  redirect
end


get '/x/:id' do
end


get '/x/:id/edit' do
end


patch 'x/:id' do
end

end


put '/x/:id' do
end


delete '/x/:id'
end


end
