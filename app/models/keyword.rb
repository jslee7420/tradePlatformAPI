class Keyword < ApplicationRecord
    validates :keyword, presence:true
    has_many :user_keyword, dependent: :delete_all
    has_many :user, through: :user_keyword, dependent: :delete_all
end