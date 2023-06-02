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

      # Tell quotes_con that it needs to support both the html and turbo_stream formats

      respond_to do |format|
        format.html { redirect_to quotes_path, notice: 'Quote was successfully created.' }
        format.turbo_stream
      end

      # redirect_to quotes_path, notice: 'Quote was successfully created.'
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

      #In the controller, let's support both the HTML and the TURBO_STREAM formats thanks to the respond_to method:
      # https://www.hotrails.dev/turbo-rails/turbo-frames-and-turbo-streams

      format.html { redirect_to quotes_path, notice: 'Quote was succesfully destroyed.' }
      format.turbo_stream                                                       # sends this view: app/views/quotes/destroy.turbo_stream.erb

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
