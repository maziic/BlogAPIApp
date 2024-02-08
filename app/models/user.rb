class User < ApplicationRecord
    has_secure_password
    has_many :posts, foreign_key: 'user_id', dependent: :destroy
    has_many :comments, foreign_key: 'author_id', dependent: :destroy
  end