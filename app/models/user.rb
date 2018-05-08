class User < ActiveRecord::Base
has_many :tweets


def slug
    username.downcase.gsub(" ","-")
  end
end
