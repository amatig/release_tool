require_relative "../core/shell"

class Git
  def initialize
    @shell = Shell.new
  end

  def tags(dir:)
    @shell.exec "git --git-dir=#{dir}/.git tag"
  end

  def info(dir:, tag:)
    output = @shell.exec "git --git-dir=#{dir}/.git show #{tag} --quiet"

    commit_prefix = "commit"
    date_prefix = "Date:"

    commit_element = output.find { |str| str.start_with?(commit_prefix) }
    commit = commit_element.sub(commit_prefix, "").strip

    date_element = output.find { |str| str.start_with?(date_prefix) }
    date = date_element.sub(date_prefix, "").strip

    return { commit: commit, date: date.normalize_date }
  end
end
