require_relative "../core/shell"

class Git
  def initialize
    @shell = Shell.new
  end

  def tags(dir:)
    output = @shell.exec "git --git-dir=#{dir}/.git tag"

    output
      .select { |tag| tag.is_valid_version }
      .sort { |tag_a, tag_b| tag_a.compare_versions(tag_b) }
  end

  def info(dir:, tag:)
    output = @shell.exec "git --git-dir=#{dir}/.git show #{tag} --quiet"

    commit_prefix = "commit"
    date_prefix = "Date:"

    commit = output
      .find { |str| str.start_with?(commit_prefix) }
      .sub(commit_prefix, "")
      .strip

    date = output
      .find { |str| str.start_with?(date_prefix) }
      .sub(date_prefix, "")
      .strip

    { commit: commit, date: date.normalize_date }
  end
end
