#spec_helper.rb

require './modules'

describe Enumerable do 
  describe "#my_map" do 
    it "iterates through the elements of array" do
      expect([1,3,5].my_map{|x| x+1}).to match_array [2,4,6]
    end
  end

  describe "#my_any" do 
    it "checks weither any element of an array is complient with a condition" do
      expect([5,7,8].my_any{|x| x>10}).to eq(false)
    end
  end


  describe "#my_none" do 
    it "checks if none of an array's element is complient with a condition" do
      expect([1,8,"8"].my_none{|x| is_a?(String)}).to be(true)
    end
  end

  describe "#my_all" do 
    it "checks if all the elements are complient with a condition" do
      expect([1,8,9,2,10].my_all{|x| x>0}).to be(true)
    end

    it "return an error if the passed array is not flattened" do
      s = NoMethodError
      expect{[1,[8,9],2,10].my_all{|x| x>0}}.to raise_error(s)
    end
  end

  describe "#my_select" do 
    it "create an sub array whose elements are complient with a condition" do
      expect((1..20).to_a.my_select{|x| x > 10}).to match_array (11..20).to_a
    end
  end

  describe "#my_inject" do 
    it "reduce array's element to a signle value using a sum operation" do
      expect((1..5).to_a.my_inject{|sum,x| sum + x }).to eq(15)
    end

    it "reduce array's element to a signle value using a multiply operation starting with 0" do
      expect((1..5).to_a.my_inject(0){|sum,x| sum * x }).to eq(0)
    end
  end

end