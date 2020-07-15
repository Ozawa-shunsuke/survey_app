class Choice < ApplicationRecord
  belongs_to :post#投稿時の保存先変更
  
  validates :post_id, presence: true
  validates :item, presence: true, length: { maximum: 30 }
end
