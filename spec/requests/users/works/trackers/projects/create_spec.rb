require 'rails_helper'

RSpec.describe "User Work Tracker Project create request", type: :request do
  describe "POST /users/works/trackers/projects/create" do
    let(:account) { create(:account) }
    # let(:project) { create(:project) }
    
    context "when user is logged in" do
      # before(:each) { post "/users/works/trackers/projects/create", params: { project: { name: Faker::Name.female_first_name, token: Faker::IDNumber.brazilian_citizen_number, slug: token, unit: %w[develop marketing].sample, status: %w[frozen in_progress canceled finished].sample } } }
      it "returns created status" do
        post "/users/works/trackers/projects/create"
        
        expect(json["status"]).to eq("created")
      end      
    end
  end

end