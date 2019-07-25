class BeerTypesController < ApplicationController
  before_action :set_beer_type, only: [:show, :update, :destroy]

  # GET /beer_types
  # GET /beer_types.json
  def index
    @beer_types = BeerType.all
  end

  # GET /beer_types/1
  # GET /beer_types/1.json
  def show
  end

  # POST /beer_types
  # POST /beer_types.json
  def create
    @beer_type = BeerType.new(beer_type_params)

    if @beer_type.save
      render :show, status: :created, location: @beer_type
    else
      render json: @beer_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beer_types/1
  # PATCH/PUT /beer_types/1.json
  def update
    if @beer_type.update(beer_type_params)
      render :show, status: :ok, location: @beer_type
    else
      render json: @beer_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beer_types/1
  # DELETE /beer_types/1.json
  def destroy
    @beer_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer_type
      @beer_type = BeerType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_type_params
      params.require(:beer_type).permit(:name, :description)
    end
end
