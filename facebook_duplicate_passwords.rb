def password_compare(prev_line, line, method)
  case method
  when :invert_first_char
    return true if ("#{line[0].swapcase}#{line[1..-1]}" == prev_line) && line.length > 0
  when :invert_all
    return true if (line.swapcase == prev_line) && line.length > 0
  when :extra_letter
  end
  rescue => e
end

dump_file = "dumps/rockyou_sorted.txt"
puts "Using file: '#{dump_file}"
prev_line = ""
first_letter_inverted_count = 0
password_inverted_count     = 0
total_count = 0
# File.open(dump_file)
%w{pass
Pass
PASS
pass
PAss?
pass1
passa
passw
passW
Passw
PassW
PASSW}.each do |line|
  line.chomp!
  total_count += 1
  if is_case_inversion_duplicate(prev_line, line)
    password_inverted_count += 1 
    # puts "##{password_inverted_count}: '#{prev_line}' == '#{line}'" if password_inverted_count%30000==0
  end
  if is_first_letter_inverted_duplicate(prev_line, line)
    first_letter_inverted_count += 1
    puts "##{first_letter_inverted_count}: '#{prev_line}' == '#{line}'" if first_letter_inverted_count%1==0
  end
  prev_line = line
end

duplicate_count = first_letter_inverted_count + password_inverted_count

puts "first_letter_inverted_count: #{first_letter_inverted_count}"
puts "password_inverted_count:     #{password_inverted_count}"
puts "duplicate_count:             #{duplicate_count}"
puts "total_count:                 #{total_count}"
puts "total/duplicate:             #{(duplicate_count*100.0/total_count).round(6)}%"

# multiple differnces can't work together
# e.g. if PaSSword then paSSword1 won't work. neither will PAaaWORD

# sort rockyou.txt -f > rockyou_sorted.txt

# what if the last 6 are: pass Pass pAss paSS PasS pASS
# pretty sure that's actually ok


# while line.lower == prev_line.lower
#   compare them with 3 methods
# end
# prev_line = line

