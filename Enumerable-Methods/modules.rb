#the module below contains self-made Enumerable methods that behaves like the original ones
module Enumerable
  def my_each(*)
    tmp=self.to_a
    for i in (0...self.length)
      tmp[i].size>0 ? yield(tmp[i][0],tmp[i][1]) :yield(i,tmp[i]) 
    end
    return tmp
  end

  def my_each_with_index(*)
    i=0
    each do |element| 
      yield(element,i) 
      i+=1  
    end
  end
  #my select
  def my_select(*)
    kr=[]
    my_each do |element| 
      d= yield element 
      kr << element if d 
    end
    return kr    
  end 
  #my all
  def my_all(*)
    res=true
    if block_given?
      my_select do |element| 
        d= yield element 
          if d==false
            res=false
            break
          end 
      end
    else
      my_select do |element|
        if element.nil? || element==false
          res=false
          break
        end
      end
    end
     res     
  end

  #my any?
  def my_any(*)
    res=false
    if block_given?
      my_select do |element| 
        d= yield element 
          if d==true 
            res=true 
            break
          end 
      end
    else
      my_select do |element|
        if element.nil? || element==false
          res=true
          break
        end
      end
    end
    res     
  end
  #my none
  def my_none(*)
    res=true 
    if block_given?
      my_select do |element| 
        d= yield element 
        if d
          res=false
          break
        end 
      end
    else
        res=false
    end
    return res     
  end
  #my count
  def my_count(*)
    res=0
    if block_given?
      my_each do |element| 
        d= yield element 
        res+=1 if d 
      end
    else 
      my_each do |element|
        res+=1  
      end 
    end
    
    return res
  end
  #my map
  def my_map (a=[])
    res=[]
    tmp=self.to_a
    if block_given?
      for i in (0...self.length)
        if (tmp[i]).is_a?(Array)
          d= yield tmp[i][0],tmp[i][1]
        else 
          d=yield tmp[i]  
        end
        res << d
      end
    else
      for i in (0...self.length)
        if (tmp[i]).is_a?(Array)
          d= a.call(tmp[i][0],tmp[i][1])
        else 
          d=a.call(tmp[i])  
        end
        res << d
      end
    end
    return res if res.size>0  
  end
#inject method
def my_inject(arg = nil)
  arr = self.class == Array ? self.slice(0..-1) : self.class == Range ? self.to_a : self.my_map {|k, v| v }
  acc = arg == nil ? arr[0] : arg
  nxt = arg == nil ? arr[1] : arr[0]
  start = arg == nil ? 1 : 0
  for i in start...arr.size
    res = yield(acc,nxt)
    acc = res
    nxt = arr[i+1]
  end
  acc
end
    
end

#multiply test
def mulitply_els(a)
  a.my_inject(1){|total,item| total*item}
end

p [1,2,3,6].my_each {|x| x+1}
[1,2,3,6].my_each_with_index {|x,item| p item}
{"cat"=>0, "dog"=>1, "wombat"=>2}.my_each{|i,item| puts "#{i} : #{item}"}
{"cat"=>0, "dog"=>1, "wombat"=>2}.my_each_with_index{|val,index| puts "#{val} : #{index}"}
=begin
[1,2,3,6].my_select {|x| x<6}
[1,5,3,9].my_none {|x| x>6}
my_proc=Proc.new do |x| 
    x+1
end
hash={"cat"=>0, "dog"=>1, "wombat"=>2}
p hash.class 
p [1,5,3,8,5,7].my_map {|x| x+1}
p [1,5,3,8,5,7].my_map(my_proc)
p hash.my_map {|key,value| {key=>value}}
p [0,5,8,7,5,2].my_inject(0){|total,item| total+item}
p hash.my_inject{|total,item| total+item}
p mulitply_els([2,5,8])
=end