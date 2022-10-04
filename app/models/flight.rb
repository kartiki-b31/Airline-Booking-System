class Flight < ApplicationRecord
    has_many :reservations, :dependent => :destroy

    validates :flight_class, inclusion: {in: %w(jumbo private small) , message: "%{values} is not a valid class"},presence: true
    validates :manufacturer,presence: true
    validates :capacity,presence: true, numericality: {only_integer: true,greater_than_or_equal_to:0}
    #validates :status, inclusion: {in: %w(available complete) , message: "%{values} is not a valid status"}
    validates :manufacturer,presence: true
    validates :cost,presence: true,numericality: true
    validates :source,presence: true
    validates :destination,presence: true
    validate :valid_trip


    private
    def valid_trip
        if source==nil || destination == nil
            errors.add("City",': Origin or destination city cannot be empty')
        elsif source == destination
            errors.add(City.find(source),': Origin or destination city cannot be empty')

        end
    end





end
