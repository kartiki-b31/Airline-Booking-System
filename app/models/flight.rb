class Flight < ApplicationRecord
    has_many :reservations, :dependent => :destroy
end
