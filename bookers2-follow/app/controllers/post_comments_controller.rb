class PostCommentsController < ApplicationController
	def create
	    @book = Book.find(params[:book_id])
	    @post_comment = current_user.post_comments.new(post_comment_params)
	    @post_comment.book_id = @book.id
	    if @post_comment.save
	       redirect_back(fallback_location: root_path)
  		else
  		   @book = Book.find(params[:book_id])
  		   @user = @book.user
  		   @books = Book.new
  		   render "books/show"#kコントローラー/アクション
  		end
	end
	def destroy
	    @post_comment = current_user.post_comments.find(params[:id])#省略形(現在のuserに紐づいたpcommentモデルの中からbook.idを見つけた)
	    @book = Book.find(params[:book_id])
	    @post_comment.book_id = @book.id
	    if @post_comment.destroy
	       redirect_back(fallback_location: root_path)
  		else
  		   @book = Book.find(params[:book_id])
  		   @user = @book.user
  		   @books = Book.new
  		   render "books/show"#kコントローラー/アクション
  		end
	end
	private
	def post_comment_params
	    params.require(:post_comment).permit(:comment)
	end
end