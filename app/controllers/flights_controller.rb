class FlightsController < ApplicationController
    before_action :set_flight, only: %i[ show edit update destroy ]
    # validates :source ,comparison: { other_than: :destination }

    # GET /flights or /flights.json
    def index
        if params[:search]
            search = '%' + params[:search] + '%'
            @flights = Flight.where('name LIKE ? or source LIKE ? or destination LIKE ?', search, search, search)
        else
            @flights = Flight.all
        end
    end

    # GET /flights/1 or /flights/1.json
    def show
    end

    # GET /flights/new
    def new
        @flight = Flight.new
    end

    # GET /flights/1/edit
    def edit
    end

    # POST /flights or /flights.json
    def create
        @flight = Flight.new(flight_params)

        respond_to do |format|
            if @flight.save
                format.html { redirect_to flights_url, notice: "Flight was successfully created." }
                format.json { render :show, status: :created, location: @flight }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @flight.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /flights/1 or /flights/1.json
    def update
        if @flight.capacity > 0
            @flight.status = 'Available'
        else
            @flight.status = 'Complete'
        end
        respond_to do |format|
            if @flight.update(flight_params)
                format.html { redirect_to flights_url, notice: "Flight was successfully updated." }
                format.json { render :show, status: :ok, location: @flight }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @flight.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /flights/1 or /flights/1.json
    def destroy
        @flight.destroy

        respond_to do |format|
            format.html { redirect_to flights_url, notice: "Flight was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_flight
        @flight = Flight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
        params.require(:flight).permit(:name, :flight_id, :source, :destination, :manufacturer, :flight_class, :capacity, :status, :cost)
    end
end
