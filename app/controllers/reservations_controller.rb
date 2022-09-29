class ReservationsController < ApplicationController
    before_action :set_reservation, only: %i[ show edit update destroy ]

    # GET /reservations or /reservations.json
    def index
        if current_user.id != nil
            @reservations = Reservation.where(user_id: current_user.id)
        else
            @reservations = Reservation.all
        end
    end

    # GET /reservations/1 or /reservations/1.json
    def show
    end

    # GET /reservations/new
    def new
        @reservation = Reservation.new
        if @flight.nil?
            @flight = Flight.find(params[:flight_id])
        end
    end

    # GET /reservations/1/edit
    def edit
    end

    # POST /reservations or /reservations.json
    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.res_id = Array.new(10) { [*"A".."Z", *"0".."9"].sample }.join
        @reservation.user = current_user
        @flight = Flight.find(params[:reservation][:flight_id])
        if @reservation.passengers > 4
            @reservation.passengers = 4
        end
        @reservation.total_cost = @flight.cost * @reservation.passengers
        @flight.capacity = @flight.capacity - @reservation.passengers
        if @flight.capacity == 0
            @flight.status = "Complete"
        end

        respond_to do |format|
            if @reservation.save
                @flight.save
                format.html { redirect_to reservations_path, notice: "Reservation was successfully created." }
                format.json { render :show, status: :created, location: @reservation }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @reservation.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /reservations/1 or /reservations/1.json
    def update
        respond_to do |format|
            if @reservation.update(reservation_params)
                format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
                format.json { render :show, status: :ok, location: @reservation }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @reservation.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /reservations/1 or /reservations/1.json
    def destroy
        @reservation.destroy

        respond_to do |format|
            format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
        params.require(:reservation).permit(:passengers, :res_id, :user_id, :flight_id, :ticket_class, :amenities, :total_cost)
    end
end
