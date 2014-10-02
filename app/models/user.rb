class User < ActiveRecord::Base
  has_many :posts, foreign_key: :creator_id, dependent: :destroy
  validates :first_name, :last_name, :email, presence: true
end
