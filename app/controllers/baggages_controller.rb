class BaggagesController < ApplicationController
    before_action :set_baggage, only: %i[ show edit update destroy ]

    # GET /baggages or /baggages.json
    def index
        if current_user.id != nil and !is_admin?
            @baggages = Baggage.where(user_id: current_user.id)
        else
            if params[:search]
                search = '%' + params[:search] + '%'
                @baggages = Baggage.where('reservation_id LIKE ? or user_id LIKE ?', search, search)
            else
                @baggages = Baggage.all
            end
        end
    end

    # GET /baggages/1 or /baggages/1.json
    def show
    end

    # GET /baggages/new
    def new
        @baggage = Baggage.new
        if @reservation.nil?
            @reservation = Reservation.find(params[:res_id])
        end
    end

    # GET /baggages/1/edit
    def edit
    end

    # POST /baggages or /baggages.json
    def create
        @baggage = Baggage.new(baggage_params)
        @baggage.baggage_id = Array.new(10) { [*"A".."Z", *"0".."9"].sample }.join
        @baggage.user = current_user
        @reservation = Reservation.find(params[:baggage][:reservation_id])
        @reservation.total_cost +=(10 * @baggage.weight.to_i)
        @baggage.baggage_cost = 10 * @baggage.weight.to_i
        respond_to do |format|
            if @baggage.save
                @reservation.save
                format.html { redirect_to reservations_path, notice: "Baggage was successfully created." }
                format.json { render :show, status: :created, location: @baggage }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @baggage.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /baggages/1 or /baggages/1.json
    def update
        @reservation = Reservation.find(@baggage.reservation_id)
        no_bags = params['baggage']['weight'].to_i - @baggage.weight.to_i
        @reservation.total_cost += 10 * no_bags
        @reservation.save
        params['baggage']['baggage_cost'] = 10 * params['baggage']['weight'].to_i
        respond_to do |format|
            if @baggage.update(baggage_params)
                format.html { redirect_to reservations_path, notice: "Baggage was successfully updated." }
                format.json { render :show, status: :ok, location: @baggage }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @baggage.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /baggages/1 or /baggages/1.json
    def destroy
        @reservation = Reservation.find(@baggage.reservation_id)
        @reservation.total_cost = @reservation.total_cost - (10 * @baggage.weight.to_i)
        @reservation.save
        @baggage.destroy

        respond_to do |format|
            format.html { redirect_to baggages_url, notice: "Baggage was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_baggage
        @baggage = Baggage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def baggage_params
        params.require(:baggage).permit(:baggage_id, :user_id, :reservation_id, :weight, :baggage_cost)
    end
end
