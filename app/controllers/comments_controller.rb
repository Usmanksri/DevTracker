class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_comment, only: [:edit, :update, :destroy]
  include ApplicationHelper


    def create
        @task = Task.find(params[:task_id])
        @comment = @task.comments.build(comment_params)
        @comment.user = current_user
        @comment.commentable_id= params[:task_id]
        @comment.commentable_type="Task"

        
        if @comment.save

          url = request.original_url.gsub(/\/comments\z/, '')
          data = { message: 'Task url path is: ', url: url }
          ActionCable.server.broadcast('comments_channel', data)

          redirect_to @task, notice: "Comment created successfully."
        else
        
            flash[:notice]= "Not updated  #{@comment.errors.full_messages}"  
          render 'new'
        end
      end

      def edit
        @task = Task.find(params[:task_id]) # Fetch the corresponding task
        @comment=Comment.find(params[:id])

      end

      def update
        @comment = Comment.find(params[:id])
        
        if @comment.update(comment_params)
          flash[:notice] = "Comment was updated successfully."
          redirect_to task_path(@comment.commentable_id)
        else
          flash[:alert] = "Comment could not be updated: #{comment.errors.full_messages.join(', ')}"
          redirect_to task_path(@comment.task)
        end
      end
      
      def destroy
        @comment = Comment.find(params[:id])
        
        if @comment.destroy
          flash[:notice] = "Comment was deleted successfully."
          redirect_to task_path(@comment.commentable_id)
        else
          flash[:alert] = "Comment could not be deleted: #{comment.errors.full_messages.join(', ')}"
          redirect_to task_path(@comment.commentable_id)
        end

      end   

      def new 
        @comment=Comment.new

      end

      private
      
      def comment_params
        params.require(:comment).permit(:content)
      end

      def authenticate_comment
        #byebug
        task = Task.find(params[:task_id])
        if not (current_project_id==task.project_id)
            flash[:notice]= "you are not authorized to perform this action"
          redirect_to tasks_path
        end
      end
      


end
