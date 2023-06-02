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
      redirect_to quotes_path, notice: 'Quote was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: 'Quote was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|

      # This code supports both the HTML and TURBO_STREAM formats (??) ~> https://www.hotrails.dev/turbo-rails/turbo-frames-and-turbo-streams
      format.html { redirect_to quotes_path, notice: 'Quote was succesfully destroyed.' }
      format.turbo_stream                     # Sends this: <turbo-stream action="remove" target="quote_908005749"></turbo-stream>

      # redirect_to quotes_path, notice: 'Quote was successfully destroyed.'
    end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
