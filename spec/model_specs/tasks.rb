require 'rails_helper'

RSpec.describe Task, type: :model do
  
  describe 'associations'  do
    it { should have_rich_text(:description) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:member).class_name('User') }
    it { should belong_to(:creator).class_name('User') } 
  end

  describe 'validations'  do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:creator_id ) }
    it { should validate_presence_of(:project_id) }
  end

  describe 'paginations' do
    it 'sets the number of records per page to 3' do
      expect(Project.per_page).to eq(3)
    end
  end
end
