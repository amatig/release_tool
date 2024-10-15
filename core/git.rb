require_relative "../core/shell"

class Git
  def initialize
    @shell = Shell.new
  end

  def tags(dir:, contains: nil)
    command = "git --git-dir=#{dir}/.git tag"
    if contains
      command += " --contains #{contains}"
    end

    output = @shell.exec command

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

  def log(dir:, from:, to:, show_dates: false)
    format = show_dates ? "%h %s, %ad" : "%h %s"
    output = @shell.exec "git --git-dir=#{dir}/.git log #{from}..#{to} --merges --pretty='#{format}'"

    output = output
      .select { |str| str.is_valid_merge }

    show_dates ? output.map { |str| str.normalize_date } : output
  end

  def find_commit(dir:, ticket:)
    output = @shell.exec "git --git-dir=#{dir}/.git log --grep='#{ticket}' --merges --pretty='%H'"

    output
      .last
      .strip
  end
end
