class ChangeCommentAttr < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :comment_type, :string
  end
end
