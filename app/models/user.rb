class User < ApplicationRecord

    has_many :reservations, :dependent => :destroy
    has_many :baggages, :dependent => :destroy
    has_secure_password

    before_save :downcase_email

    validates   :email ,format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid" }, presence: true, uniqueness: true

    validates   :card, presence: true, format: {with: /[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}/, message: "should be in xxxx-xxxx-xxxx-xxxx format."}

    validates :mobile, format: {with: /[0-9]{10}/, message: "should be 10 digits"}

    validates :name, presence: true
    private

    def downcase_email
        self.email = email.downcase
    end
end
