class Article < ActiveRecord::Base
  # Ensures these fields are filled out when
  # creating a new article
  validates :title, presence: true
  validates :body, presence: true

  # database association to a single user
  belongs_to :user
  # can have many comments and if article is deleted
  # those comments will be deleted too
  has_many :comments, dependent: :destroy

  # Lists articles most recent first
  default_scope {order(created_at: :desc)}
end
