class News::UserConfig < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
end
