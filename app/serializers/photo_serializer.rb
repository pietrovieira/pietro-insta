class PhotoSerializer < ActiveModel::Serializer
  attributes :width, :height, :format, :resource_type, :bytes, :url, :secure_url
end
