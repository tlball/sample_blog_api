class Post < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :post_categories, dependent: :destroy
  has_many :categories, :through => :post_categories

  validates :creator_id, presence: true

  accepts_nested_attributes_for :post_categories, :allow_destroy => true
end
