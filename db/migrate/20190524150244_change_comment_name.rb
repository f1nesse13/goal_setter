class ChangeCommentName < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :comment_id, :commentable_id
    rename_column :comments, :comment_type, :commentable_type
  end
end
