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

  def search
    if (params[:state].nil? && params[:city].present?) || search_params.empty?
      render_invalid_search_response
    else
      render json: MarketSerializer.new(Market.search_all(search_params))
    end
  end
  
  def nearest_atms
    market = Market.find(params[:id])
    atm_facade = AtmFacade.new
    atms = atm_facade.find_nearby_atms(market.lat, market.lon)

    render json: atms, status: :ok
  end

  private

  def error_response(message, status)
    render json: { errors: [{ detail: message }] }, status: status
  end

  def search_params
    params.permit(:state, :city, :name)
  end

  def render_invalid_search_response
    error_message = ErrorMessage.new("Invalid search parameters", 422)
    render json: ErrorSerializer.serialize(error_message.message), status: 422
  end
end