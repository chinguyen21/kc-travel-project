class City < ApplicationRecord
    has_many :destinations
    belongs_to :state
    has_one :country, through: :state
    validates :name, uniqueness: true
end