class BooksController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.recommended_by = current_user.email
    @book.status = 'To buy'
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end

  def buy
    @book = Book.find(params[:id])
    if @book.status == "To buy"
      @book.status = "To let"
      if @book.save
        redirect_to @book, :notice => "The book has been registered."
      else
        render :action => "show"
      end
    else
      redirect_to @book, :alert => "This book has been registered."
    end
  end

  private
    def book_params
      params.require(:book).permit(:isbn, :name, :author, :note)
    end

end
