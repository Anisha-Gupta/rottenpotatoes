require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "GET 'show'" do
    it "should be successful" do
      movie1 = Movie.create(title: 'Star Wars', director: 'George Lucas')
      get :show, {:id =>1}
      response.should be_success
    end
  end
  describe 'samedirector' do
    it 'redirects to movies_path when the movie has no director info' do
      movie = Movie.create(title: 'Alien', director: '') # Create a movie with no director info
      get :samedirector, {:id=>1}
      expect(flash[:notice]).to eq("'#{movie.title}' has no director info.")
      expect(response).to redirect_to(movies_path)
    end

    it 'assigns movies with the same director' do
      director = 'George Lucas'
      movie1 = Movie.create(title: 'Star Wars', director: director)
      movie2 = Movie.create(title: 'THX-1138', director: director)

      get :samedirector, {:id=>1}

      expect(assigns(:movies)).to contain_exactly(movie1, movie2)
    end

    it 'renders the samedirector template' do
      movie = Movie.create(title: 'Blade Runner', director: 'Ridley Scott')
      get :samedirector, {:id=>1}
      expect(response).to render_template('samedirector')
    end
  end
end
