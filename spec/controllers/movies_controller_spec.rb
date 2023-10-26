require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
describe "GET 'same_director'" do
    it "should loads movies of same director into @movies" do
      get :same_director, :id => @StarWars.id
      assigns(:movies).should include(@THX1138)
    end
    it "should not include movies of different director into @movies" do
      get :same_director, :id => @StarWars.id
      assigns(:movies).should_not include(@BladeRunner)
    end
    it 'flashes a message for a movie with no director info' do
      get :same_director, :id => @Alien.id
      expect(flash[:notice]).to include("'#{movie.title}' has no director info.")
      expect(response).to redirect_to(movies_path)
    end
  end
end
