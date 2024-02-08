class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments

  validates :title, :body, :tags, presence: true
  validates :user_id, presence: true # Use user_id instead of author_id

  after_create_commit :update_comments_count
  after_destroy_commit :update_comments_count

  private

  def update_comments_count
    return if destroyed?
    update_column(:comments_count, comments.count)
  end
end