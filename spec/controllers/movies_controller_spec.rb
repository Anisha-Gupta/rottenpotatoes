require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'create' do
    it 'creates a new movie' do
      expect {
        post :create, { movie: { title: 'Inception', director: 'Christopher Nolan' } }
      }.to change(Movie, :count).by(1)
    end

    it 'redirects to movies_path after creating a movie' do
       post :create, { movie: { title: 'Inception', director: 'Christopher Nolan' } }

      expect(response).to redirect_to(movies_path)
    end

    it 'sets a flash notice message' do
      post :create, { movie: { title: 'Inception', director: 'Christopher Nolan' } }

      expect(flash[:notice]).to eq("Inception was successfully created.")
    end
  end
  describe 'show' do
    it 'assigns the requested movie to @movie' do
      movie = Movie.create(title: 'Star Wars', director: 'George Lucas')
      get :show, {:id=>1}
      expect(assigns(:movie)).to eq(movie)
    end

    it 'renders the show template' do
      movie = Movie.create(title: 'Star Wars', director: 'George Lucas')
      get :show, {:id=>1}
      expect(response).to render_template('show')
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
  describe 'destroy' do
    it 'deletes a movie' do
      movie = Movie.create(title: 'Inception', director: 'Christopher Nolan')

      expect {
        delete :destroy, {:id=>1}
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to movies_path after deleting a movie' do
      movie = Movie.create(title: 'Inception', director: 'Christopher Nolan')

      delete :destroy, {:id=>1}

      expect(response).to redirect_to(movies_path)
    end

    it 'sets a flash notice message' do
      movie = Movie.create(title: 'Inception', director: 'Christopher Nolan')

      delete :destroy, {:id=>1}

      expect(flash[:notice]).to eq("Movie '#{movie.title}' deleted.")
    end
  end
end
