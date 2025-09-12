class AddStateToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :publication_state, :integer
  end
end
