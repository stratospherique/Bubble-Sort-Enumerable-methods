# the module below contains self-made Enumerable methods that behaves like the original ones
module Enumerable
  def my_each(*)
    tmp = self.to_a
    is_hash=tmp.is_a?(Hash)
    res=[]
    if is_hash
      for i in (0...tmp.length)
        d = yield(tmp[i][0],tmp[i][-1])
        res << d if d.is_a?(Hash)
      end
      return res if res.size>0
    else
      for i in (0...tmp.length)
       d = yield(tmp[i])
       res << d
      end
      return res if res.size>0
    end
    tmp
  end

  def my_each_with_index(*)
    i = 0
    each do |element|
      yield(element, i)
      i += 1
    end
  end

  # my select
  def my_select(*)
    kr = []
    my_each do |element|
      d = yield element
      kr << element if d
    end
    kr
  end

  # my all
  def my_all()
    res = true
    if block_given?
      my_each do |element|
        d = yield element
        if d == false
          res = false
          break
        end
      end
    else
      my_each do |element|
        if element.nil? || element == false
          res = false
          break
        end
      end
    end
    res
  end

  # my any?
  def my_any(*)
    res = false
    if block_given?
      my_select do |element|
        d = yield element
        if d == true
          res = true
          break
        end
      end
    else
      my_select do |element|
        if element.nil? || element == false
          res = true
          break
        end
      end
    end
    res
  end

  # my none
  def my_none(*)
    res = true
    if block_given?
      my_select do |element|
        d = yield element
        if d
          res = false
          break
        end
      end
    else
      res = false
    end
    res
  end

  # my count
  def my_count(*)
    res = 0
    if block_given?
      my_each do |element|
        d = yield element
        res += 1 if d
      end
    else
      my_each do |_element|
        res += 1
      end
    end

    res
  end

  # my map
  def my_map(a = [])
    res = []
    tmp = self.to_a
    is_array = tmp[0].is_a?(Array) ? true : false 
    if block_given?
      if is_array
        my_each do |key,value|
        d = yield key, value
        res << d
        end
      else
        my_each do |item|
          d = yield item
          res << d
        end
      end 
    else
      if is_array
        my_each do |key,value|
        d=a.call(key, value)
        res << d
        end
      else
        my_each do |item|
          d=a.call(item)
          res << d
        end
      end
    end
    return res unless res.empty?
  end

  # inject method
  def my_inject(arg = nil)
    arr = self.class == Array ? slice(0..-1) : self.class == Range ? to_a : my_map { |_k, v| v }
    acc = arg.nil? ? arr[0] : arg
    nxt = arg.nil? ? arr[1] : arr[0]
    start = arg.nil? ? 1 : 0
    (start...arr.size).each do |i|
      res = yield(acc, nxt)
      acc = res
      nxt = arr[i + 1]
    end
    acc
  end
end

# multiply test
def mulitply_els(a)
  a.my_inject(1) { |total, item| total * item }
end
