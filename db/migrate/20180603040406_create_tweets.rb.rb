class CreateTweets.rb < ActiveRecord::Migration
  def change
      create_table :tweets do |t|
        t.string   :name
        t.string   :content
        t.string   :password_digest

    end
  end
end


# <h1>Index Page</h1>
#
# Welcome to Sinatra Security. Please <a href="/signup">Sign Up</a> or <a href="/login">Log In</a> to continue.
