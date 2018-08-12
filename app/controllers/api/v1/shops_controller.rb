class Api::V1::ShopsController < ApplicationController
  def index
    shops =
      Shop.joins(stocks: :book)
          .where("publisher_id = #{params[:publisher_id]} and books_sold_count >= 1")
          .group(:id)
          .order('SUM(books_sold_count) DESC')

    render json: shops, status: :ok, publisher_id: params[:publisher_id]
  end
end
