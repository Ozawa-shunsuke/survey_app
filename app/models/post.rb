class Post < ApplicationRecord#::Base
  belongs_to :user
  has_many :result_post, dependent: :destroy#新しく作った
  has_many :choices, dependent: :destroy#投稿時の保存先変更
  accepts_nested_attributes_for :choices
  default_scope -> { order(created_at: :desc) }
  validates :user_id,     presence: true
  validates :title,       presence: true, length: { maximum: 40  }
  validates :description, presence: true, length: { maximum: 400 }
  validates_associated :choices
end
