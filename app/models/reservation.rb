class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :flight
    has_many :baggages, :dependent => :destroy


    validates :ticket_class, inclusion: {in: %w(first business economy) , message: "%{values} is not a valid class"},presence: true

    validates :passengers,presence: true, numericality: {only_integer: true,greater_than_or_equal_to:0,less_than_or_equal_to:4}
    validates :amenities, inclusion: {in: %w(all wifi leg-space food) , message: "%{values} is not a valid class"},presence: true
    validates :res_id,presence: true, uniqueness: true
    validates :total_cost,presence: true,numericality: true

end
