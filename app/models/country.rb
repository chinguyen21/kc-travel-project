class Country < ApplicationRecord
    has_many :states
    has_many :cities, through: :states
    has_many :destinations, through: :cities
    validates :name, uniqueness: true
end