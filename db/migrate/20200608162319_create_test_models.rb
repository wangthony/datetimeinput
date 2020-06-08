class CreateTestModels < ActiveRecord::Migration[6.0]
  def change
    create_table :test_models do |t|
      t.timestamp :datetime

      t.timestamps
    end
  end
end
