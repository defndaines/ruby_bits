# Generate a random string of UTF-8 characters.
#
def random_string(length = 16)
  @@valid_utf = [(0x20..0x7e), (0xc2..0xd7ff)].map { |i| i.to_a }.flatten unless defined? @@valid_utf
  (1..length).reduce("") { |s| s << @@valid_utf[rand(@@valid_utf.size)] }
end
