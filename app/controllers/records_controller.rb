class RecordsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @records = Record.all
    @bk_name = Book.name
  end

  def new
    @book = Book.find(params[:bk_id])
    if @book.status == "To buy"
      redirect_to books_path, :notice => "This book is not bought yet."
    elsif @book.status == "Lent"
      redirect_to books_path :notice => "This book is lent out."
    else
      @record = Record.new
      @record.book_id = params[:bk_id]
      @record.user_id = current_user.id
      @record.check_out_date = Date.today
    end
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to records_path
    else
      render 'new'
    end
  end

  def show
    @record = Record.find(params[:id])
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    redirect_to records_path
  end

  def edit
    @record = Record.find(params[:id])
    @record.check_in_date = Date.today
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to records_path
  end



  private
    def record_params
      params.require(:record).permit(:book_id, :user_id, :check_out_date, :check_in_date)
    end

end
