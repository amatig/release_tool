class Array
  def pretty_row(column_sizes, separator = "   ")
    rows = each_with_index.map do |str, index|
      str.ljust(column_sizes[index])
    end

    rows.join(separator)
  end
end
