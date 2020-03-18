class EnablePostgis < ActiveRecord::Migration[6.0]
  def up
    execute 'CREATE EXTENSION postgis;'
  end
  def down
    execute 'DROP EXTENSION postgis;'
  end
end
