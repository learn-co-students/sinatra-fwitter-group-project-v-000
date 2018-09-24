1. GEMFILE -->  DONE
2. Environment.rb --> DONE
3. Models [app/models]:
    a) User < ActiveRecord::Base
    b) Tweet < ActiveRecord::Base
4. Migrations
    a) Users table
        i) username as text
        ii) email as text
        iii) password using BCrypt, store in table as :password_digest
    b) Tweets table
        i) content as text
        ii) user_id (foreign key)