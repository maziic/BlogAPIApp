class Comment < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :post
  
    validates :body, :author_id, :post_id, presence: true
  
    after_create_commit :increment_post_comments_count
    after_destroy_commit :decrement_post_comments_count
  
    private
  
    def increment_post_comments_count
      post.increment!(:comments_count)
    end
  
    def decrement_post_comments_count
      post.decrement!(:comments_count)
    end
  end
  