class ReservationsController < ApplicationController
    before_action :set_reservation, only: %i[ show edit update destroy ]

    # GET /reservations or /reservations.json
    def index
        if current_user.id != nil and !is_admin?
            @reservations = Reservation.where(user_id: current_user.id)
        else
            if params[:search]
                search = '%' + params[:search] + '%'
                @reservations = Reservation.where('user_id LIKE ?', search)
            else
                @reservations = Reservation.all
            end
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
        if is_admin?
            if User.find(params[:reservation][:user_id])
                @reservation.user = User.find(params[:reservation][:user_id])
            else
                @reservation.errors = "User does not exists"
            end
        else
            @reservation.user = current_user
        end
        @flight = Flight.find(params[:reservation][:flight_id])
        if @flight.capacity > @reservation.passengers
            @flight.capacity = @flight.capacity - @reservation.passengers
            @reservation.total_cost = @flight.cost * @reservation.passengers

        else
            @reservation.passengers = @reservation.passengers - @flight.capacity
            @reservation.total_cost = @flight.cost * @reservation.passengers
            @flight.capacity = 0
        end
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
        @flight = Flight.find(@reservation.flight_id)
        @flight.capacity = @flight.capacity + @reservation.passengers
        puts @reservation.passengers
        puts params['reservation']['passengers']
        puts @flight.capacity
        params['reservation']['total_cost']  = @reservation.total_cost - (@flight.cost * @reservation.passengers)
        if @flight.capacity > params['reservation']['passengers'].to_i
            @flight.capacity = @flight.capacity - params['reservation']['passengers'].to_i
            params['reservation']['total_cost'] += @flight.cost * params['reservation']['passengers'].to_i
        else
            params['reservation']['passengers'] = params['reservation']['passengers'].to_i - @flight.capacity
            params['reservation']['total_cost'] += @flight.cost * params['reservation']['passengers'].to_i
            @flight.capacity = 0
        end
        if @flight.capacity == 0
            @flight.status = "Complete"
        else
            @flight.status = "Available"
        end
        respond_to do |format|
            if @reservation.update(reservation_params)
                @flight.save
                format.html { redirect_to reservations_path, notice: "Reservation was successfully updated." }
                format.json { render :show, status: :ok, location: @reservation }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @reservation.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /reservations/1 or /reservations/1.json
    def destroy
        @flight = Flight.find(@reservation.flight_id)
        @flight.capacity = @flight.capacity + @reservation.passengers
        @flight.save
        @reservation.destroy

        respond_to do |format|
            format.html { redirect_to reservations_path, notice: "Reservation was successfully destroyed." }
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
