class ProjectMember < ApplicationRecord 
    
    belongs_to :user, foreign_key: 'member_id'
    belongs_to :project

    validates_uniqueness_of :member_id, scope: :project_id

end