class ProjectsController < ApplicationController

    before_action :set_project, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    load_and_authorize_resource

  

    def index
        if current_user.role == "manager"
          @projects = current_user.created_projects.includes(:creator).paginate(page: params[:page])
        else
          @projects = current_user.projects.includes(:creator).paginate(page: params[:page])
        end
        respond_to do |format|
          format.html
          format.js
        end
      end
      

    def new
        @project=Project.new

    end


    def select_project
        project_id = params[:project_id]
        cookies[:selectedProjectId] = project_id
        redirect_to tasks_path
      end



    def show
    end

    def create
        @project=Project.new(project_params)

        @project.creator_id=current_user.id
        
        if @project.save
        flash[:notice]= "Project added Successfully"
        redirect_to tasks_path

        else
         render 'new'
        end
    end


    def edit
    end

    def update
      
        if @project.update(project_params)
            flash[:notice] = "Project was updated successfully."
            redirect_to projects_path
        else
            flash[:alert]= "Project not updated."
            redirect_to projects_path
        end
    end

   
    def destroy
        @project.destroy
        redirect_to projects_path, notice: 'Project deleted successfully.'
      end
      

    
    def project_params
        params.require(:project).permit(:name, :description, member_ids: []).tap do |whitelisted|
            whitelisted[:description] = params[:project][:description]
        end
        
    end
    

    def set_project
        @project=Project.find(params[:id])
      end
end
