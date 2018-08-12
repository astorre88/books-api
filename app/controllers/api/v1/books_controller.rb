class Api::V1::BooksController < ApplicationController
  def update
    status, response =
      SellBook.call(shop_id: params[:shop_id], book_id: params[:id], copies_number: book_params[:copies])

    case status
    when :ok
      head :no_content
    when :error
      render json: { error: response }, status: :bad_request
    end
  end

  private

  def book_params
    params.require(:book).permit(:copies)
  end
end
