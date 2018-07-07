module ButtonMaker

  def can_return?
    @book.status == "Checked Out" && @userbook.status == "Checked Out"
  end

  def set_submit_message
    can_return? ? "Return Book" : "Check Out"
  end

  def change_book_status
    @book.status == "Available" ? "Checked Out" : "Available"
  end

  def user_book_status_options?
    @book.status == "Available" ?  false  : true
  end

  def set_button_form_locals
    if @book.interactable?
      @button = set_submit_message
      @global_status = change_book_status
      @user_status_choice = user_book_status_options?
    end
  end

end
