class DataImport < ActiveRecord::Base
  require 'csv'
  require 'digest/md5'  

  has_many :purchases

  def initialize(file)
    raise "No file selected" unless file

    super()
    file_hash = Digest::MD5.hexdigest(File.read(self.file_path))    
    raise "File has already been imported" if DataImport.find_by_file_hash(file_hash)

    self.file_path = file.path
    self.file_hash = file_hash
    self.save
  end

  def process
    parsed_file = CSV.read(self.file_path, { :col_sep => "\t", :headers => true })

    parsed_file.each do |row|
      merchant = Merchant.where(name: row.field('merchant name'), address: row.field('merchant address')).first_or_create
      item = Item.where(description: row.field('item description'), price: row.field('item price'), merchant_id: merchant.id).first_or_create
      purchaser = Purchaser.where(name: row.field('purchaser name')).first_or_create
      Purchase.create!(count: row.field('purchase count'), item_id: item.id, purchaser_id: purchaser.id, data_import_id: self.id)
    end
    self.completed = true
    self.save
  end

  def calculate_revenue
    self.purchases.inject(0){ |total,purchase| total += purchase.count * purchase.item.price }
  end
end