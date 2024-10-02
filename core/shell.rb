require 'open4'

class Shell

  def execute(command)
    pid, stdin, stdout, stderr = Open4::popen4 command 

    error = stderr.read.strip
    payload = stdout.read.strip

    if error.empty?
      return payload
    else
      raise error
    end
  end

end