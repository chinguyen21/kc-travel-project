class User < ApplicationRecord
    has_many :user_events
    has_many :events, through: :user_events
    has_many :destinations, through: :events
    has_many :itineraries
    has_many :favorites
    has_many :reviews
    has_many :entries, through: :itineraries
    has_many :events, through: :entries


   
    validates :name, presence: true
    validates :age, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 8}
    has_secure_password

end
