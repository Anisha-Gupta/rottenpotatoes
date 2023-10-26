require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'samedirector' do
    it 'redirects to movies_path when the movie has no director info' do
      movie = Movie.create(title: 'Movie Title', director: '') # Create a movie with no director info
      get :samedirector, params: { id: movie.id }
      expect(flash[:notice]).to eq("'#{movie.title}' has no director info.")
      expect(response).to redirect_to(movies_path)
    end

    it 'assigns movies with the same director' do
      director = 'Director Name'
      movie1 = Movie.create(title: 'Movie 1', director: director)
      movie2 = Movie.create(title: 'Movie 2', director: director)

      get :samedirector, params: { id: movie1.id }

      expect(assigns(:movies)).to contain_exactly(movie1, movie2)
    end

    it 'renders the samedirector template' do
      movie = Movie.create(title: 'Movie Title', director: 'Director Name')
      get :samedirector, params: { id: movie.id }
      expect(response).to render_template('samedirector')
    end
  end
end
