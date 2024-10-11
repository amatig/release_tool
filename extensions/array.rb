class Array
  def find_prev(value)
    index = index(value)
    index && index > 0 ? self[index - 1] : nil
  end
end
