require 'spec_helper'

describe MoviesController do
  before :each do
    @Alien = FactoryGirl.create(:Alien)
    @StarWars = FactoryGirl.create(:StarWars)
    @THX1138 = FactoryGirl.create(:THX1138)
    @BladeRunner = FactoryGirl.create(:BladeRunner)
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @Alien.id
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @Alien.id
      assigns(:movie).should == @Alien
    end
  end

  describe "GET 'same_director'" do
    it "should loads movies of same director into @movies" do
      get :same_director, :id => @StarWars.id
      assigns(:movies).should include(@THX1138)
    end
    it "should not include movies of different director into @movies" do
      get :same_director, :id => @StarWars.id
      assigns(:movies).should_not include(@BladeRunner)
    end
  end
end
