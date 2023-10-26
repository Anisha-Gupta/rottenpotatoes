class Movie < ActiveRecord::Base
  def self.find_all_by_director(director)
    where(director: director)
  end
end
