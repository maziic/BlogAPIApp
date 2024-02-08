class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :body
end
class AuthorSerializer < ActiveModel::Serializer
  attributes :name, :image
end
class PostDetailsSerializer < ActiveModel::Serializer
    belongs_to :author, serializer: AuthorSerializer
    attributes :id, :title, :body, :tags
    has_many :comments
end
