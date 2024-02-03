module BooksHelper
  def my_book?(book)
    book.user_id == current_user.id
  end
end
