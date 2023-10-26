require 'rails_helper'
require 'spec_helper'

RSpec.describe Movie, type: :model do
  it "returns movies with the same director" do
    # Create movies with the same director
    director = 'George Lucas'
    movie1 = Movie.create(title: 'Star Wars', director: director)
    movie2 = Movie.create(title: 'THX 1138', director: director)

    # Create a movie with a different director
    Movie.create(title: 'Blade Runner', director: 'Ridley Scott')

    # Call the find_all_by_director method
    movies = Movie.find_all_by_director(director)

    # Expect the method to return movies with the same director
    expect(movies).to include(movie1)
    expect(movies).to include(movie2)
  end

  it "returns an empty array for a director with no matching movies" do
    # Create movies with different directors
    Movie.create(title: 'Star Wars', director: 'George Lucas')
    Movie.create(title: 'THX 1138', director: 'George Lucas')

    # Call the find_all_by_director method for a director with no matching movies
    movies = Movie.find_all_by_director('Ridley Scott')

    # Expect the method to return an empty array
    expect(movies).to be_empty
  end
end
