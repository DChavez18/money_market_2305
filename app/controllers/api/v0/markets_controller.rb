class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      market = Market.find(params[:id])
      render json: MarketSerializer.new(market)
    rescue ActiveRecord::RecordNotFound
      error_response("Couldn't find Market with 'id'=#{params[:id]}", :not_found)
    end
  end

  private

  def error_response(message, status)
    render json: { errors: [{ detail: message }] }, status: status
  end
end