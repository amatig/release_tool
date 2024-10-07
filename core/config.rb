class Config
  def self.isValidTag(tag)
    tag =~ /^GR\d{2}\.\d{1,2}\.\d{1,2}$/
  end

  def self.compareVersions(a, b)
    # Use regex to extract numeric components
    a_match = a.match /^GR(\d{2})\.(\d{1,2})\.(\d{1,2})$/
    b_match = b.match /^GR(\d{2})\.(\d{1,2})\.(\d{1,2})$/

    # Compare the groups numerically
    # Extracting and converting to integers for comparison
    [
      a_match[1].to_i,    # Year
      a_match[2].to_i,    # Month
      a_match[3].to_i,    # Cut
    ] <=> [
      b_match[1].to_i,
      b_match[2].to_i,
      b_match[3].to_i,
    ]
  end
end
