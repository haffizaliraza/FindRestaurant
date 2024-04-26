class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :commentable, polymorphic: true
      t.bigint :parent_id
      t.bigint :root_node_id
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
