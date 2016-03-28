class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    # set :views, 'app/views'
    set :views, Proc.new { File.join(root, "../views/") }
  end

  get '/' do
    binding.pry
    erb :'index'
  end
end
