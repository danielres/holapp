class News::UserConfig < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  validates :user_id, presence: true
end
