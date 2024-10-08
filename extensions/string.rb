class String
  @@tag_regex = /^GR(\d{2})\.(\d{1,2})\.(\d{1,2})$/

  def is_valid_version
    begin
      extract_version != nil
    rescue
      false
    end
  end

  def extract_version
    match_found = match @@tag_regex
    raise "Issue with tag version format" if match_found == nil || match_found.size < 4

    return match_found[1].to_i, match_found[2].to_i, match_found[3].to_i
  end

  def compare_versions(other_version)
    extract_version <=> other_version.extract_version
  end
end

# Extension for pretty output
class String
  def pretty_row_separator(column_sizes, separator = "   ")
    output = column_sizes.map do |size|
      self * size
    end

    output.join(separator).strip
  end
end
