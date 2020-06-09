class AddDateTimeColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :test_models, :date, :date
    add_column :test_models, :time, :time
  end
end
