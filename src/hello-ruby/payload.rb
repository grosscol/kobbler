# A hello world payload
def perform(name, number_of_greetings)
  greeting = ''
  number_of_greetings.times do
    greeting += "Hello, #{name}\n" 
  end
  return greeting
end
