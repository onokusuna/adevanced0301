class Favorite < ApplicationRecord
	belongs_to :user#belong_toだから親は単数形
	belongs_to :book
end
