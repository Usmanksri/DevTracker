class Project < ApplicationRecord 

    has_rich_text :description
    belongs_to :creator, class_name: 'User'
    has_many :tasks, foreign_key: 'project_id', dependent: :destroy
    has_many :project_members,  dependent: :destroy
    has_many :members, through: :project_members, source: :user,  dependent: :destroy
    validates :name, presence: true
    validates :description, presence: true
    self.per_page = 3

end
