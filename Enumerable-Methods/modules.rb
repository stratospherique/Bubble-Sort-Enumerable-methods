module Enumerable
    def my_each(&block)
        res=[]
        each do |element| 
        
                d= yield element 
            res << d 
    
        end
        p res 
        return res
    end

    def my_each_with_index(&block)
        i=0
        each do |element| 
            
            element.is_a?(Array) ? yield(i,element[0]) :yield(i,element) 
           i+=1  
    
        end
       
    end
end

[1,2,3,6].my_each {|x| x+=1}
[1,2,3,6].my_each_with_index {|x,item| p item}
{"cat"=>0, "dog"=>1, "wombat"=>2}.my_each_with_index{|i,item| p item}