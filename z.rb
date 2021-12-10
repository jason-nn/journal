def sum(arr)
  return [] if !arr.respond_to? :each || arr.length < 1
  output = [0, 0]
  arr.each { |x| x > 0 ? output[0] += 1 : output[1] += x }
  return output
end

sample = (1..15).map { |x| x < 11 ? x : -x }

pp sample

pp sum sample

pp sum []

pp sum nil
