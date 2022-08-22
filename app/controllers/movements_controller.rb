class MovementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movement, only: %i[ show edit update destroy ]

  # GET /movements or /movements.json
  def index
    @movements = collection.order(date: :desc)
    @balance = collection.balance
  end

  # GET /movements/new
  def new
    @movement = collection.new
  end


  # POST /movements or /movements.json
  def create
    @movement = collection.new(movement_params)

    respond_to do |format|
      if @movement.save
        format.html { redirect_to movements_url, notice: "Movement was successfully created." }
        format.json { render :show, status: :created, location: @movement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1 or /movements/1.json
  def destroy
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to movements_url, notice: "Movement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def collection
      current_user.movements
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_movement
      @movement = collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movement_params
      params.require(:movement).permit(:date, :description, :value, :typeof)
    end
end
