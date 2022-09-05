$:.unshift(File.join("..", "lib"))

require "micromidi"

# Prints some MIDI messages to standard out

MIDI.using($stdout) do

  # set sticky values
  channel 4
  velocity 64

  # create some objects
  note_msg = note "C4"
  controller_msg = cc 2, 120
  patch_change_msg = pc 5

end