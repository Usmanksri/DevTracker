class Comment < ApplicationRecord 
    has_rich_text :content
    belongs_to :user
    belongs_to :task, optional: true
    after_create_commit { broadcast_append_to 'comments' }
end
