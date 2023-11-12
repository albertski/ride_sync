# frozen_string_literal: true

module Api
  module V1
    class DriverRidesController < ApplicationController
      def index
        driver = params[:driver]
        page = params[:page] || 1
        distance = params[:distance] || 100

        begin
          @driver_rides = Kaminari
                          .paginate_array(DriverRidesService.fetch(Driver.find(driver), distance)).page(page).per(10)
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Driver not found' }, status: :not_found
        end
      end
    end
  end
end
