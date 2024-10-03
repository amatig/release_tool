require 'open4'

class Shell

  def exec(command)
    pid, stdin, stdout, stderr = Open4::popen4 command

    error = stderr.read.strip

    if !error.empty?
      fail error
    end

    stdout.read.strip
  end

end