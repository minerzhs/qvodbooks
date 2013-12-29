class RecordsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
    @record.book_id = params[:bk_id]
    @record.user_id = current_user.id
    @record.check_out_date = Date.today
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to records_path
    else
      render 'new'
    end
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
