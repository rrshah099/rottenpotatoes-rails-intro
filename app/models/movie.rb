class Movie < ActiveRecord::Base
    
    
    def self.getSortedTitle
        @sorted_movies = Movie.order(:title)
    end
    
    def self.getSortedRating
        @sorted_movies = Movie.order(:rating => datetime)
    end
end
