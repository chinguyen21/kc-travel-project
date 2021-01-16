class Itinerary < ApplicationRecord
    belongs_to :user
    has_many :entries 
    has_many :events, through: :entries 
    has_many :destinations, through: :events
    validates :name, presence: true
    accepts_nested_attributes_for :entries
end
