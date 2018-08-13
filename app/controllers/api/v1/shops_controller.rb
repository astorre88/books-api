class Api::V1::ShopsController < ApplicationController
  def index
    shops = Shop.with_sold_books(params[:publisher_id])

    render json: shops, status: :ok, publisher_id: params[:publisher_id]
  end
end
