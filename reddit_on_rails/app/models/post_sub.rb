class PostSub < ApplicationRecord
  belongs_to :sub,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :Sub

  belongs_to :post,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :Post
end
