require 'rails_helper'

RSpec.describe "Projects", type: :request do
  include Devise::Test::IntegrationHelpers

  describe "POST /projects" do
  let!(:user) { FactoryBot.create(:user, role: 'manager') }

  before do
    sign_in user
  end

    # project should created with valid parameter
    context "with valid parameters" do
      let(:project_params) do
        {
          project: {
            name: 'Sample Project',
            description: 'Sample Project Description',
            creator_id: user.id
          }
        }
      end

      it "creates a new project" do
        expect {
          post "/projects", params: project_params
        }.to change(Project, :count).by(1)
        expect(flash[:notice]).to eq("Project added Successfully")
      end
    end
    
    # project should not created with invalid parameters
    context "with invalid parameters" do
      let(:invalid_project_params) do
        {
          project: {
            name: '',
            description: '',
            creator_id: user.id
          }
        }
      end

      it "does not create a project" do
        expect {
          post "/projects", params: invalid_project_params
        }.not_to change(Project, :count)

        expect(response).to render_template(:new)
        expect(response.body).to include("Name can&#39;t be blank")
        expect(response.body).to include("Description can&#39;t be blank")
      end
    end
  end
end
