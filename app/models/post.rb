class Post < ApplicationRecord#::Base
  belongs_to :user
  has_many :result_post, dependent: :destroy#新しく作った
  has_many :choices, dependent: :destroy#投稿時の保存先変更
  accepts_nested_attributes_for :choices
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id,     presence: true
  validates :title,       presence: true, length: { maximum: 400  }
  
  validates :description, presence: true, length: { maximum: 400 }
  validate  :picture_size
  
  #def vote(user)
    #result_post.create(user_id: user.id)投票機能
  #end
  
  #def vote_cancel(user)
    #result_post.find_by(user_id: user.id).destroy投票取り消し機能
  #end  
  
  private
  
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB未満にしてください")
      end 
    end    
end
