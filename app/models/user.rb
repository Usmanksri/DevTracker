class User < ApplicationRecord 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :tasks, foreign_key: 'creator_id'
    has_many :tasks, foreign_key: 'member_id', class_name: 'Task'
    has_many :comments, foreign_key: 'user_id'


    has_many :project_members, foreign_key: 'member_id'
    has_many :projects, through: :project_members
    has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id'

     # Devise modules
    devise :database_authenticatable, :registerable, :validatable
  
end