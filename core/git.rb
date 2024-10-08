require_relative "../core/shell"

class Git
  def initialize
    @shell = Shell.new
  end

  def tags(dir)
    @shell.exec "git --git-dir=#{dir}/.git tag"
  end
end
