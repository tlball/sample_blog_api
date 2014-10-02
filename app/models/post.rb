class Post < ActiveRecord::Base
  belongs_to :creator, :class_name => User
  has_many :post_categories
  has_many :categories, :through => :post_categories
end
