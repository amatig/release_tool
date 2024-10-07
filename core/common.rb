class Common
  def self.isValidTag(tag)
    tag =~ /^GR\d{2}\.\d{1,2}\.\d{1,2}$/
  end

  def self.extractVersion(tag)
    match = tag.match /^GR(\d{2})\.(\d{1,2})\.(\d{1,2})$/

    raise "Issue with tag version format" if match.size < 4

    return match[1].to_i, match[2].to_i, match[3].to_i
  end

  def self.compareVersions(tagA, tagB)
    extractVersion(tagA) <=> extractVersion(tagB)
  end
end
