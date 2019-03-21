class Follow < ApplicationRecord
  # belongs_to :follow, class_name: "User", foreign_key: follow_id
  # belongs_to :follower, class_name: "USer", foreign_key: user_id

  belongs_to :followings, class_name: "User", foreign_key: :from_user_id
  belongs_to :follower, class_name: "User", foreign_key: :to_user_id
end
