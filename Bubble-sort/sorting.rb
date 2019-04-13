def bubble_sort(a)
  ch=true
  while ch
    ch=false
    (a.length-1).times do |i|
    if (a[i]>a[i+1])
      a[i],a[i+1]=a[i+1],a[i]
      ch=true 
    end 
    end
  end 
  a
end

#print bubble_sort([1,8,9,7,2,5,0,20,3])

def bubble_sort_by (a)
  ch=false
  if block_given?
  until ch 
    ch=true 
    (a.length-1).times do |i|
      d=yield(a[i],a[i+1])
      if d>0
        a[i],a[i+1]=a[i+1],a[i]
        ch=false
      end
    end
  end 
  else
    bubble_sort(a)
  end
  a
end

p bubble_sort_by(["hi","hello","hey","bycicle","o"]) do |left,right|
      left.length - right.length
 end