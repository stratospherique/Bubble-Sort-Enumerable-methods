def bubble_sort(a)
    ch=true
    while ch
        ch=false
        (a.length-1).times do |i|
        if (a[i]>a[i+1])
            tmp=a[i]
            a[i]=a[i+1]
            a[i+1]=tmp 
            ch=true 
        end 
        end
    end 
    p a
end

#print bubble_sort([1,8,9,7,2,5,0,20,3])

