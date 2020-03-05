class FavoritesController < ApplicationController
        def create
            book = Book.find(params[:book_id])
            favorite = current_user.favorites.new(book_id: book.id)#省略形(現在のuserに紐づいたfavoriteモデルに空のインスタ作成してその中にbook.idを入れた)
            favorite.save
            redirect_back(fallback_location: root_path)
        end
        def destroy
            book = Book.find(params[:book_id])
            favorite = current_user.favorites.find_by(book_id: book.id)#省略形(現在のuserに紐づいたfavoriteモデルの中からbook.idを見つけた)
            favorite.destroy
            redirect_back(fallback_location: root_path)
        end
end
