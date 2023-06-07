class Task < ApplicationRecord 
    has_rich_text :description
    has_many :comments, foreign_key: 'commentable_id', dependent: :destroy
    belongs_to :member, class_name: 'User', foreign_key: 'member_id'    
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
    validates :title, :description, :creator_id, :project_id, presence: true
    self.per_page = 3
end
