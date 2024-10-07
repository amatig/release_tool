require_relative "../core/shell"

class Git
  def initialize
    @shell = Shell.new
  end

  def tags(path)
    @shell.exec "git --git-dir=#{path}/.git tag"
  end
end
