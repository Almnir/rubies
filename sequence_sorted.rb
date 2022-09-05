text = %q[
I agree with you
I say what you do about the world
It's poison
And it's sick
And you want to get out of it
]

puts File.read('freq.txt').downcase.split(/[^a-zA-z]+/).tally.sort_by { |h| [-h[1], h[0]]}.map {|x| x[1].to_s + " " + x[0] + "\n" }.join