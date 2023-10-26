require 'spec_helper'

describe Movie do
  it "function should return movies of same director" do
    @StarWars.find_all_by_director.should include(@THX1138)
  end

  it "function should return movies of same director" do
    @StarWars.find_all_by_director.should_not include(@BladeRunner)
  end
end