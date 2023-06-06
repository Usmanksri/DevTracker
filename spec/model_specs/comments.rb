require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'association' do
    it { should have_rich_text(:content) }
    it { should belong_to(:user) }
  end

  describe "database columns" do
    it { should have_db_column(:commentable_type).of_type(:string).with_options(null: false) }
    it { should have_db_column(:commentable_id).of_type(:integer).with_options(null: false) }
  end
end
