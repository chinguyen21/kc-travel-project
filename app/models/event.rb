class Event < ApplicationRecord
    belongs_to :destination 
    has_many :entries
    has_many :itineraries, through: :entries
    has_many :user_events
    has_many :users, through: :user_events

    validates :name, uniqueness: true
end
