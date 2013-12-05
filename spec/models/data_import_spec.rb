require 'spec_helper'

describe DataImport do
  before(:each) do
    generate_file("purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name\n" +
                  "Snake Plissken\t$10 off $20 of food\t10.0\t2\t987 Fake St\tBob's Pizza\n" +
                  "Amy Pond\t$30 of awesome for $10\t10.0\t5\t456 Unreal Rd\tTom's Awesome Shop\n" +
                  "Marty McFly\t$20 Sneakers for $5\t5.0\t1\t123 Fake St\tSneaker Store Emporium\n" +
                  "Snake Plissken\t$20 Sneakers for $5\t5.0\t4\t123 Fake St\tSneaker Store Emporium\n")
    @data_import = DataImport.new(@file)
  end

  after(:each) do
    File.delete(@file.path)
  end

  it "generates desired data" do
    @data_import.process
    Merchant.all.size.should == 3
    Purchaser.all.size.should == 3
    Item.all.size.should == 3
    Purchase.all.size.should == 4
  end

  it "generates the desired data when two different files are processed" do
    @data_import.process
    generate_file("purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name\n" +
                  "John Smith\t$10 off $20 of food\t10.0\t4\t987 Fake St\tBob's Pizza\n" )
    data_import = DataImport.new(@file)
    data_import.process
    Merchant.all.size.should == 3
    Purchaser.all.size.should == 4
    Item.all.size.should == 3
    Purchase.all.size.should == 5
  end

  it "calculates the revenue correctly" do
    @data_import.process
    @data_import.calculate_revenue.should == 95.0
  end


  it "calculates the revenue correctly when processing with different purchases" do
    @data_import.process
    generate_file("purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name\n" +
                  "John Smith\t$10 off $20 of food\t10.0\t4\t987 Fake St\tBob's Pizza\n" )
    data_import = DataImport.new(@file)
    data_import.process
    data_import.calculate_revenue.should == 40.0
  end
end

def generate_file(contents)
  @file = File.open("testfile#{Time.now.to_s}.tab", 'w')
  @file.write(contents)
  @file.close
end