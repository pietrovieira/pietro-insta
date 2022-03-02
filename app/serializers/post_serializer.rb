class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :photo, serializer: PhotoSerializer
end
