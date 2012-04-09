class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  class Movie::NoDirectorError < StandardError; end
    def self.similar_movies(id)
      m = Movie.find id
      logger.info "movie=#{m.inspect}"
      unless m.director.blank?
        Movie.find_all_by_director m.director
      else
        raise Movie::NoDirectorError, "'#{m.title}' has no director info"
      end
    end
    def similar_movies
      if self.director
        Movie.find_all_by_director self.director
      else
        raise Movie::NoDirectorError, "#{self.title} has no director info"
      end
    end
  end
end
