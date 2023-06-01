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


    def render_attachments(content)
      attachments = content.body.attachments
      
      attachments.map do |attachment|
        link_to url_for(attachment), target: '_blank' do
          image_tag url_for(attachment.variant(resize_to_limit: [10, 10]))
        end
      end.join.html_safe
    end
    

end
