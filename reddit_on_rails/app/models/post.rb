class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :subpost,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :Sub

  belongs_to :author,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
end
