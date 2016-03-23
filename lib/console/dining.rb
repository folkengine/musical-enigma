Pry::Commands.create_command 'dining' do
  description 'Runs Dining Philosophers problem code'

  def options(opt)
    opt.on :u, :uncoordinated, 'Runs uncoordinated version of the problem'
    opt.on :w, :waiter,        'Runs the Waiter version of the problem'
    opt.on :a, :actor,         'Runs actor based version of the problem'
  end

  def process
    if opts.uncoordinated?
      uncoordinated
    elsif opts.waiter?
      waiter
    elsif opts.actor?
      actor
    else
      puts opts
    end
  end

  def actor
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| CelluloidPhilosopher.new(name) }

    waiter = CelluloidWaiter.new # no longer needs a "capacity" argument
    table = Table.new(philosophers.size)

    philosophers.each_with_index do |philosopher, i|
      # No longer manually create a thread, rely on async() to do that for us.
      philosopher.async.dine(table, i, waiter)
    end

    sleep
  end

  def uncoordinated
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| Philosopher.new(name) }
    table        = Table.new(philosophers.size)

    threads = philosophers.map.with_index do |philosopher, i|
      Thread.new { philosopher.dine(table, i) }
    end

    threads.each(&:join)
    sleep
  end

  def waiter
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| WaitedOnPhilosopher.new(name) }

    table  = Table.new(philosophers.size)
    waiter = Waiter.new(philosophers.size - 1)

    threads = philosophers.map.with_index do |philosopher, i|
      Thread.new { philosopher.dine(table, i, waiter) }
    end

    threads.each(&:join)
    sleep
  end
end

