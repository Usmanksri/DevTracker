class Project < ApplicationRecord 

    has_rich_text :description

    has_many :tasks, foreign_key: 'project_id', dependent: :destroy

    belongs_to :creator, class_name: 'User'
    has_many :project_members,  dependent: :destroy
    has_many :members, through: :project_members, source: :user,  dependent: :destroy

    validates :name, presence: true
    validates :description, presence: true
    
    self.per_page = 3

end