class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :flight
    has_many :baggages, :dependent => :destroy
end
