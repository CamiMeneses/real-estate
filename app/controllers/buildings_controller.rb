class BuildingsController < ApplicationController
  before_action :building, only: %i[show update destroy]

  def index
    buildings = Building.all.order(:created_at)

    render json: buildings.to_json(only: %i[id name type_cd city country])
  end

  def show
    render json: @building
  end

  def create
    building = Building.new(building_params)
    if building.save
      render json: { mssg: 'Building Created', building: building }, status: :created
    else
      render json: { mssg: building.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  rescue ArgumentError => e
    render json: { mssg: e.message }
  end

  def update
    @building.assign_attributes(building_params)
    if @building.save
      render json: { mssg: 'Building Updated', building: @building }, status: :ok
    else
      render json: { mssg: @building.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  rescue ArgumentError => e
    render json: { mssg: e.message }
  end

  def destroy
    if @building.destroy
      render json: { mssg: 'Building Deleted', building: @building }, status: :ok
    else
      render json: { mssg: @building.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def building_params
    params.required(:building).permit(:name, :type_cd, :street, :external_number, :internal_number,
                                      :neighborhood, :city, :country, :rooms, :bathrooms, :comments)
  end

  def building
    @building = Building.find(params[:id])
  end
end
