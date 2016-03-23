class WaitedOnPhilosopher
  def initialize(name)
    @name = name
  end

  def dine(table, position, waiter)
    @left_chopstick  = table.left_chopstick_at(position)
    @right_chopstick = table.right_chopstick_at(position)

    loop do
      think

      # instead of calling eat() directly, make a request to the waiter
      waiter.serve(table, self)
    end
  end

  def think
    puts "#{@name} is thinking"
  end

  def eat
    # take_chopsticks
    # Now handled by the waiter

    puts "#{@name} is eating."

    drop_chopsticks
  end

  def take_chopsticks
    @left_chopstick.take
    @right_chopstick.take
  end

  def drop_chopsticks
    @left_chopstick.drop
    @right_chopstick.drop
  end
end