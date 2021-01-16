class State < ApplicationRecord
    has_many :cities
    has_many :destinations, through: :cities
    belongs_to :country

    validates :name, uniqueness: true
end