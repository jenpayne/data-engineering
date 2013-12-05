class Purchase < ActiveRecord::Base
	belongs_to :purchaser
	belongs_to :item
	belongs_to :data_import
end
