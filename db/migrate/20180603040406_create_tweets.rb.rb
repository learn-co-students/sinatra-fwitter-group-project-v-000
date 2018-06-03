class CreateTweets.rb < ActiveRecord::Migration
  def change
      create_table :tweets do |t|
        t.string   :name
        t.string   :content
        t.string   :password_digest

    end
  end
end
