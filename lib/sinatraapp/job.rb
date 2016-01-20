module Job
  @queue = :default

  def self.perform(options)
    puts options
  end
end
