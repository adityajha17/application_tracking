class Job < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :category, presence: true,
            :inclusion => { :in => %w(full-time part-time backend frontend) }
    validates :exp, presence: true,
            format: {with: /[0-9]+/, message: "Should be integer"},
            numericality: { greater_than: 0 }
    validate :status
end
