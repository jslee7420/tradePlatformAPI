class Keyword < ApplicationRecord
  validates :keyword, presence: true, length: {maximum: 20}
  # validates :count , :presence => true
  has_many :user_keyword, dependent: :delete_all
  has_many :user, through: :user_keyword, dependent: :delete_all
end
