class Api::V1::LocationsController < Api::V1::BaseController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = policy_scope(Location).page(params[:page]).per(params[:per])

    render json: @locations
  end

  # GET /locations/1
  def show
    authorize @location
    render json: @location
  end

  # POST /locations
  def create
    @location = Location.new(permitted_attributes(Location.new))
    authorize @location #Authorizing

    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  def update
    authorize @location
    if @location.update(permitted_attributes(@location))
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    authorize @location
    @location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
end
