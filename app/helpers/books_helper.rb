module BooksHelper
  def my_book?(book)
    book.user_id == current_user.id
  end

  def my_user?(user)
    user = current_user
  end

end
