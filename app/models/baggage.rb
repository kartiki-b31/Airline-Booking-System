class Baggage < ApplicationRecord
    belongs_to :user
    belongs_to :resevation
    belongs_to :flight
end
