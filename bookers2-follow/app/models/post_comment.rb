class PostComment < ApplicationRecord
	belongs_to :user#belong_toだから親は単数形
	belongs_to :book
	validates :comment, presence: true
end
