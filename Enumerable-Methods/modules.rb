module Enumerable
    def my_each(*)
        res=[]
        each do |element| 
        
                d= yield element 
            res << d 
    
        end
        #p res 
        return res
    end

    def my_each_with_index(&block)
        i=0
        each do |element| 
            
            element.is_a?(Array) ? yield(i,element[0]) :yield(i,element) 
           i+=1  
    
        end
       
    end
    def my_select(&block)
        kr=[]
        my_each do |element| 
                d= yield element 
                kr << element if d 
        end
       # p kr 
        return kr    
    end 
    def my_all(&block)
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
        puts res 
        return res     
    end
    def my_any(&block)
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
        puts res 
        return res     
    end
    
    def my_none(&block)
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
        puts res 
        return res     
    end

    def my_count(&block)
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

    def my_map (*)
        res=[]
        
        if block_given?
            my_each do |element|
             d= yield element
                res << d
            end
        else
            return nil 
        end
        return res if res.size>0  
         
    end

    def my_inject (ins=1)
        sum=ins 
        mult=ins 
        sub=ins 
        sum_check=false  
        mult_check=false 
        sub_check=false
        if block_given?
                d=yield ins,self[0]
            if (d/ins==self[0])
                mult_check=true 
            elsif (d+ins==self[0])
                sub_check=true 
            elsif (d-ins==self[0])
                sum_check=true 
            else 
                return 0
            end
            my_each do |element|
             yield ins,element
             if mult_check
                mult*=element 
            elsif sub_check
                sub-=element  
            else sum_check
                sum+=element
             end
                
            end
        else
            return 0 
        end
        return sum if sum_check
        return mult if mult_check
        return sub if sub_check
         
    end
    
end

p [1,2,3,6].my_each {|x| x+=1}
[1,2,3,6].my_each_with_index {|x,item| p item}
{"cat"=>0, "dog"=>1, "wombat"=>2}.my_each_with_index{|i,item| p item}
[1,2,3,6].my_select {|x| x<6}
[1,5,3,9].my_none {|x| x>6}
p [1,5,3,8,5,7].my_map {|x| x+1}
p [1,5,8,7,5,2].my_inject(2){|total,item| total*item}
