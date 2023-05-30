class Task < ApplicationRecord 
    has_rich_text :description
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
    belongs_to :member, class_name: 'User', foreign_key: 'member_id'    
    has_many :comments, foreign_key: 'commentable_id', dependent: :destroy
    validates :title, :description, :creator_id, :project_id, presence: true
end