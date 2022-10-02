class User < ApplicationRecord

    has_many :reservations, :dependent => :destroy
    has_many :baggages, :dependent => :destroy
    has_secure_password

    before_save :downcase_email

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

    private

    def downcase_email
        self.email = email.downcase
    end
end
