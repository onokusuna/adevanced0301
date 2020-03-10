class Book < ApplicationRecord
	belongs_to :user#belong_toだから親は単数形
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)#いいねしているかどうか(trueかfalseか)
	    favorites.where(user_id: user.id).exists?
	end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
