class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    @comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    Comment.find(params[:id]).destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
