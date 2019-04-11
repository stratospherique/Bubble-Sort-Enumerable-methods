module Enumerable
    def my_each(*)
        for i in (0...self.length)
            yield self[i]
        end
        return self
    end

    def my_each_with_index(*)
        i=0
        each do |element| 
            
            element.is_a?(Array) ? yield(i,element[0]) :yield(i,element) 
           i+=1  
    
        end
       
    end
    def my_select(*)
        kr=[]
        my_each do |element| 
                d= yield element 
                kr << element if d 
        end
       # p kr 
        return kr    
    end 
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
        puts res 
        return res     
    end
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
        puts res 
        return res     
    end
    
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
        puts res 
        return res     
    end

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

    def my_map (a=[])
        res=[]
        if block_given?
            my_each do |element|
             d= yield element
                res << d
            end
        else
            my_each do |element|
                d=a.call(element)
                res << d
            end
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
                d=yield 5,2
            if (d/5==2) 
                mult_check=true
            elsif (d+5==2)
                sub_check=true 
            elsif (d-5==2)
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

def mulitply_els(a)
    a.my_inject(1){|total,item| total*item}
end

p [1,2,3,6].my_each {|x| x+1}
[1,2,3,6].my_each_with_index {|x,item| p item}
{"cat"=>0, "dog"=>1, "wombat"=>2}.my_each_with_index{|i,item| p item}
[1,2,3,6].my_select {|x| x<6}
[1,5,3,9].my_none {|x| x>6}
my_proc=Proc.new do |x| 
    x+1
end
p [1,5,3,8,5,7].my_map {|x| x+1}
p [1,5,3,8,5,7].my_map(my_proc)
p [0,5,8,7,5,2].my_inject(0){|total,item| total+item}
p mulitply_els([2,5,8])