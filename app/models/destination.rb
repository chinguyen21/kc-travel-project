class Destination < ApplicationRecord
    has_many :events
    has_many :user_events, through: :events
    has_many :users, through: :user_events
    has_many :entries, through: :events
    has_many :reviews
    belongs_to :city
    has_one :state, through: :city 
    has_one :country, through: :state
    accepts_nested_attributes_for :events, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
    validates :name, uniqueness: true
    validates :name, :picture_link, presence: true

    def self.find_by_city(city_id)
        Destination.where(city_id: city_id)
    end
    
    def self.find_by_state(state_id)
        Destination.all.select {|d| d.state == State.find(state_id)}
    end

    

    def self.most_popular_destinations
        hash = Hash.new(0)
        Entry.where('visited = true').map {|entry| entry.destination}.each {|d| hash[d]+=1}
        hash.sort_by {|key,value| -value}.map {|a| a[0]}
    end

    def self.average_rating_destinations
        h1 = Review.group(:destination).sum(:rating)
        h2 = Review.group(:destination).count
        h1.each {|key,value| h1[key] = value / h2[key].to_f}
        h1
    end

    def self.highest_to_lowest_rating_destinations
        average_rating_destinations.sort_by {|key,value| -value}
    end

    def self.lowest_to_highest_rating_destinations
        average_rating_destinations.sort_by {|key,value| value}
    end

    def self.highest_rating
        hash = Hash.new(0)
        Review.all.each {|review| hash[review.destination] += review.rating}
        hash
    end
end
