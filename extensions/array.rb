# Extension for pretty output
class Array
  def pretty_row(column_sizes, separator = "   ")
    output = each_with_index.map do |str, index|
      str.ljust(column_sizes[index])
    end

    output.join(separator).strip
  end
end
