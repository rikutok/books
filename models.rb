require 'bundler/setup'
Bundler.require


if development?
    ActiveRecord::Base.establish_connection('sqlite3:db/development.db')
end

class Answer < ActiveRecord::Base
end

class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    
     validates :name,
        presence: true,
    format: { with: /\A\w+\z/ }
        validates :password,
    length: { in: 4..10 }
      
end

class Post< ActiveRecord::Base
    belongs_to :user
end