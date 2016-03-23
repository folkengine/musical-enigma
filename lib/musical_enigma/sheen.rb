require 'celluloid/current'

class Sheen
  include Celluloid

  def initialize(name)
    @name = name
  end

  def set_status(status)
    @status = status
  end

  def report
    "#{@name} is #{@status}"
  end
end