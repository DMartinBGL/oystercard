class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :journey_history
  

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1 


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey_history = Hash.new
  end

  def top_up(amount)
    fail "Maximum limit £#{MAXIMUM_BALANCE} exceeded" if limit(amount)
    @balance += amount
  end

  def limit(topup)
    @balance + topup > MAXIMUM_BALANCE
  end

  def minimum
    @balance < MINIMUM_BALANCE
  end 

  def touch_in(station)
    fail "Not enough funds." if minimum
    @in_journey = true 
    @entry_station = station
    @journey_history[@entry_station] = nil
  end 
  
  def touch_out(exit_station) 
    @in_journey = false 
    @balance -= MINIMUM_BALANCE
    @entry_station = nil
    @exit_station = exit_station

  end 

  def on_journey?
    !!@entry_station
  end

  private 

  def deduct(amount)
    @balance -= amount
  end
end
