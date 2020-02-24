# sieve_of_eratosthenes.rb

# class Sieve
#   def initialize(limit)
#     @limit = limit
#   end
  
#   def primes
#     primes = []
#     composites = []

#     2.upto(@limit) do |number|
#       if composites.include?(number)
#         next
#       else
#         primes << number
#         2.upto(@limit / number) { |multiple| composites << number * multiple }
#       end
#     end
    
#     primes
#   end
# end

class Sieve
  def initialize(limit)
    @limit = limit
  end
  
  def primes
    results = Hash.new(0)

    2.upto(@limit) do |number|
      if results[number] == "composite"
        next
      else
        results[number] = "prime"
        2.upto(@limit / number) do |multiple|
          results[number * multiple] = "composite"
        end
      end
    end
    
    primes = []
    results.each { |key, value| primes << key if value == "prime" }
    primes
  end
end
