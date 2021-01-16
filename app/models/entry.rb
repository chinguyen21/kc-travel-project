class Entry < ApplicationRecord
    belongs_to :itinerary
    belongs_to :event
    has_one :destination,through: :event
    validates :date, presence: true

end