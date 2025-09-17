class BankAccount
  def initialize(owner, balance)
    @owner = owner
    @balance = balance
  end

 
  public

  def deposit(amount)
    @balance += amount
    puts " Deposited $#{amount}. New balance: $#{@balance}"
  end

  def withdraw(amount)
    if amount <= @balance
      @balance -= amount
      puts "💸 Withdrew $#{amount}. Balance before fee: $#{@balance}"
      apply_fee   
      puts "After fee: $#{@balance}"
    else
      puts "Insufficient funds"
    end
  end

  def show_balance
    puts "🔎 Current balance for #{@owner}: $#{@balance}"
  end

  
  private

  def apply_fee
    fee = 10
    @balance -= fee
    puts " Bank fee of $#{fee} applied"
  end
end

account = BankAccount.new("Ali", 100)
account.show_balance
account.deposit(50)
account.withdraw(80)

