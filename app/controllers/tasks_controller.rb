class TasksController < ApplicationController

    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authenticate_project, only: [:edit, :update, :destroy]

    include ApplicationHelper
    
    def index
        @tasks=Task.where(project_id: current_project_id).paginate(page: params[:page], per_page: 3)
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new
        @task=Task.new
    end

    def create
        @task=Task.new(task_params)
        @task.creator_id=current_user.id
        @task.project_id=current_project_id
        if @task.save
            flash[:notice] = "Task was created successfully."
            redirect_to tasks_path
        else
           render 'new'
        end

    end

    def edit

    end

    def update
        if @task.update(task_params)
          flash[:notice] = "Task was updated successfully." unless request.xhr?
          respond_to do |format|
            format.html { redirect_to tasks_path }
            format.json { render json: { success: true } }
          end
        else
          flash.now[:notice] = "Task update failed. #{@task.errors.full_messages}"
          redirect_to tasks_path
        end
      end
      
    
    def show
        @comments = Comment.where(commentable_id: params[:id]).order(created_at: :desc)
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: 'Task deleted successfully.'
    end

    def set_task
        @task=Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:title, :description, :member_id, :project_id, :status, :priority)
    end


    def authenticate_project
        task = Task.find(params[:id])
        if not (current_project_id==task.project_id)
            flash[:notice]= "you are not authorized to perform this action"
          redirect_to tasks_path
        end
      end
      


end
