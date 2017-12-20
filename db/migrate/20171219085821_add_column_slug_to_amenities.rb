class AddColumnSlugToAmenities < ActiveRecord::Migration
  def change
    add_column :amenities, :slug, :string
    add_index :amenities, :slug
  end
end
