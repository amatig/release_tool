class Common
  def self.is_valid_tag(tag)
    tag =~ /^GR\d{2}\.\d{1,2}\.\d{1,2}$/
  end

  def self.extract_version(tag)
    match = tag.match /^GR(\d{2})\.(\d{1,2})\.(\d{1,2})$/
    raise "Issue with tag version format" if match.size < 4

    return match[1].to_i, match[2].to_i, match[3].to_i
  end

  def self.compare_versions(tagA, tagB)
    extract_version(tagA) <=> extract_version(tagB)
  end
end
