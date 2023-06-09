class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
    @user = current_user
    @newbook = Book.new
    @book_comment = BookComment.new
  end

  def index
    case params[:order]
    when 'created_at_desc'
      @books = Book.order(created_at: :desc)
    when 'star_desc'
      @books = Book.order(star: :desc)
    else
      @books = Book.left_joins(:favorites)
                   .group(:id)
                   .order('COUNT(favorites.id) DESC')
    end
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :tag, :star)
  end
end
