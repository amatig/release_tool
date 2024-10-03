require_relative '../core/shell'

class Release

  def list(path)
    begin
      shell = Shell.new

      puts shell.exec "ls -l #{path}"
    rescue => error
      puts error
    end
  end

end