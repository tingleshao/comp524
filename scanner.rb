# comp 524 lab1
# author: chong shao (cshao@cs.unc.edu
# scanner for a calculator language


$MOV_RULE = ["Si", "Sp", "So", "SA", "ii", "id", "iB", "Ad", "dB", "BC", "Cr", "Br", "rr"]
$END_STATE = "opidr"

def scan(input)
  state = 'S'
  input[0].split(//).each do |s|
  #  puts "s: " + s
    state = scanOne(state,s)
	puts "state: " + state
  end
  	puts "state o: " + state

  if $END_STATE.include?(state)
	  puts "parse success" 
  else 
      puts "parse error at final char"
  end

end

def scanOne(state, char)
  if state == 'S'
    if checkState("1234567890", char, 'i', "read digit")
      state = 'i'
      puts "read digit"
    elsif "+-*/^".include?(char)
      state = 'o'
	  puts "read operator"
	elsif char == '.'
	  state = 'A'
	  puts "read dot"
	elsif "()".include?(char)
	  state = 'p'
	  puts "read paren"
	else 
	  puts "scanning error"
	  state = 'e'
    end 
  elsif state == 'i'
    if "1234567890".include?(char)
      state = 'i'
      puts "read digit"
	elsif '.' == char
	  state = 'd'
	  puts "read dot"
	elsif "eE".include?(char)
	  state = 'B'
	  puts "read exp symbol"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  elsif state == 'A'
    if "1234567890".include?(char)
	  state = 'd'
	  puts "read digit"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  elsif state == 'd' 
    if "1234567890".include?(char)
	  state = 'd'
	  puts "read digit"
    elsif "eE".include?(char)
	  state = 'B'
	  puts "read exp symbol"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  elsif state == 'B'
    if "+-".include?(char)
	  state = 'C'
	  puts "read pos neg symbol"
	elsif "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  elsif state == 'C'
    if "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  elsif state == 'r'
    if "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "scanning error"
	  state = 'e'
	end
  end
  return state
end

def checkState(ruleStr, char, state, info)
  if ruleStr.include?(char)
    return true 
  end
  return false
end


if __FILE__ == $0
   # puts ARGV
    scan(ARGV)
end


