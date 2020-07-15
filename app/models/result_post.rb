class ResultPost < ApplicationRecord
    belongs_to :user
    belongs_to :post#新しく作った
    
    #validates :user_id, presence: true
    #validates :post_id, presence: true
end
