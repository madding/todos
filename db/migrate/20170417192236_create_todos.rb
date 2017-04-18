class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.integer :index
      t.text :status, default: 'new'

      t.timestamps
    end
  end
end
