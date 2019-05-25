class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  def correct_redirect
    self.commentable_type == "Goal" ? "goal_url(self.id)" : "user_url(self.id)"
  end
end
