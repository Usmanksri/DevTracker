require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers 

  let!(:manager) { FactoryBot.create(:user, :manager, email: 'manager@example.com') }

  before do
    sign_in manager 
  end

  let!(:project) { FactoryBot.create(:project) }
  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the project and redirects to projects path' do
        new_name = 'Updated Project Name'
        new_description = 'Updated Project Description'

        patch :update, params: { id: project.id, project: { name: new_name, description: new_description } }

        project.reload
        expect(project.name).to eq(new_name)
        expect(project.description.to_plain_text).to eq(new_description)

        expect(flash[:notice]).to eq('Project was updated successfully.')
        expect(response).to redirect_to(projects_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the project and redirects to projects path' do
        invalid_name = ''
        invalid_description = ''

        patch :update, params: { id: project.id, project: { name: invalid_name, description: invalid_description } }

        project.reload
        expect(project.name).not_to eq(invalid_name)
        expect(project.description).not_to eq(invalid_description)

        expect(flash[:alert]).to include("Project not updated.")
        expect(response).to redirect_to(projects_path)
      end
    end

  end
end
