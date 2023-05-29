module ApplicationHelper
    def current_project_id
        #byebug
       selected_project_id = cookies[:selectedProjectId]
       if (selected_project_id.nil? || selected_project_id == "")
         nil
       else
         puts("Id found is there", selected_project_id.to_i)
         selected_project_id.to_i
       end
     end
       
end
