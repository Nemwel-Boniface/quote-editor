class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  def index
    @quotes = Quote.all
  end

  def show
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to quotes_path, notice: "Quote was created succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote was updated succesfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @quote.destroy
        redirect_to quotes_path, notice: "Quote was deleted successfully."
    else
        error_message = @quote.errors.full_messages.to_sentence.presence || "There was an error deleting the quote."
        redirect_to quotes_path, alert: error_message
    end
    rescue => e
      logger.error "Destroy failed: #{e.message}"
      redirect_to quotes_path, alert: "An unexpected error occurred: #{e.message}"
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
