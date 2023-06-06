require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers 

  let!(:manager) { FactoryBot.create(:user, :manager, email: 'manager@example.com') }
  let!(:member1) { FactoryBot.create(:user, :member, email: 'member1@example.com') }
  let!(:member2) { FactoryBot.create(:user, :member, email: 'member2@example.com') }


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
    it 'does not create a new project with invalid parameters' do
      project_params = {
        name: '',
        description: ''
      }
    
      project = Project.new(project_params)
      expect(project).to_not be_valid
      expect {
        post :create, params: { project: project_params }
      }.to_not change(Project, :count)
    
      expect(response).to render_template(:new)
      expect(project.errors[:name]).to include("can't be blank")
      expect(project.errors[:description]).to include("can't be blank")
    end
    
  end
end
