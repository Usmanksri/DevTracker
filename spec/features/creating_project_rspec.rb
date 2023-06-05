require 'rails_helper'
require 'support/user_helper'

RSpec.describe ProjectsController, type: :controller do
  include UserHelper
  include Devise::Test::ControllerHelpers 

  let!(:manager) { create_user('manager') }
  let!(:member1) { create_user('member') }
  let!(:member2) { create_user('member') }

  before do
    sign_in manager 
  end

  describe 'POST #create' do
    it 'creates a new project with valid parameters' do
      project_params = {
        name: 'Test Project',
        description: 'Test Project Description',
        member_ids: [member1.id,member2.id]
      }

      expect {
        post :create, params: { project: project_params }
      }.to change(Project, :count).by(1)

      expect(flash[:notice]).to eq('Project added Successfully')
      expect(response).to redirect_to(tasks_path)
    end
  end
end
