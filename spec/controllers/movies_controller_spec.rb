require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
describe 'samedirector' do
    it "should load movies of same director into @movies" do
      get :samedirector, params: { id: @StarWars.id }
      assigns(:movies).should include(@THX1138)
    end
    it "should not include movies of different director into @movies" do
      get :samedirector, params: { id: @StarWars.id }
      assigns(:movies).should_not include(@BladeRunner)
    end
    it 'flashes a message for a movie with no director info' do
      movie = Movie.create(title: 'Movie Title', director: '')
      get :samedirector, params: { id: movie.id }
      expect(flash[:notice]).to include("'#{movie.title}' has no director info.")
      expect(response).to redirect_to(movies_path)
    end
  end
end
