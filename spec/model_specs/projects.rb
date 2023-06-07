require 'rails_helper'

RSpec.describe Project, type: :model do

  describe 'associations' do
    it { should have_rich_text(:description) }
    it { should have_many(:tasks).dependent(:destroy) }
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:project_members).dependent(:destroy) }
    it { should have_many(:members).through(:project_members).source(:user).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'pagination' do
    it 'sets the number of records per page to 3' do
      expect(Project.per_page).to eq(3)
    end
  end
end
