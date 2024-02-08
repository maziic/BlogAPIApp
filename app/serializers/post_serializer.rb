class AuthorSerializer < ActiveModel::Serializer
  attributes :name, :image
end

class PostSerializer < ActiveModel::Serializer
  belongs_to :author, serializer: AuthorSerializer
  attributes :author, :id, :title, :body, :tags, :comments_count
end