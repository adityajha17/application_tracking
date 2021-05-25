class Admin < ApplicationRecord
    validates :name, presence: true
    validates :mobile, presence: true,
            format: {with: /\A\d{10}\z/, message: "Mobile number should be valid"},
            uniqueness: true
    
end
