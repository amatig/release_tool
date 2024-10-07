require_relative "../core/git"

class Release
  def initialize
    @git = Git.new
  end

  def list(path)
    begin
      list = @git.tags path

      list.each do |tag|
        puts "--> #{tag}"
      end
    rescue => error
      puts error
    end
  end
end
