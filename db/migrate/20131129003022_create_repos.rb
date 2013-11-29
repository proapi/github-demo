class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.references :user, index: true
      t.string :url
      t.integer :stargazers_count
      t.integer :forks_count
      t.boolean :public

      t.timestamps
    end
  end
end
