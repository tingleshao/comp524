# comp 524 lab1
# author: chong shao (cshao@cs.unc.edu
# scanner for a calculator language


$MOV_RULE = ["Si", "Sp", "So", "SA", "ii", "id", "iB", "Ad", "dB", "BC", "Cr", "Br", "rr"]
$END_STATE = "opidr"
$DIGIT_STATE = "idr"
$tokens = []
$bufferedToken = ""
def scan(input)
  state = 'S'
  bufferedToken = ''
  states = [] 
  inputArray = input[0].split(//)
  begin_index = 0
  end_index = 0
  inputArray.each do |s|
  #  puts "s: " + s
    state = scanOne(state,s)
	#puts "state: " + state
	
	    puts "scan success, " + state 
	   states << state

	     $bufferedToken = $bufferedToken + s
	puts "current state: " + state
	
  end
  #	puts "state o: " + state
 $tokens << $bufferedToken
 $tokens = $tokens[1..-1]
  if $END_STATE.include?(state)
      puts "scanning error at final char"
	  
	  puts states.to_s
	  puts $tokens.to_s
	 else
	  puts "www"
	  puts states.to_s
	  puts $tokens.to_s
  end

end

def startState(char)
    $tokens << $bufferedToken
	$bufferedToken = ""
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
	return state 
end

def scanOne(state, char)
  if state == 'S'
    state = startState(char)
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
	  puts "token finished"
	  state = startState(char)
	end
  elsif state == 'A'
    if "1234567890".include?(char)
	  state = 'd'
	  puts "read digit"
	else 
	  puts "token finished"
	  state = startState(char)
	end
  elsif state == 'd' 
    if "1234567890".include?(char)
	  state = 'd'
	  puts "read digit"
    elsif "eE".include?(char)
	  state = 'B'
	  puts "read exp symbol"
	else 
	  puts "token finished"
	  state = startState(char)
	end
  elsif state == 'B'
    if "+-".include?(char)
	  state = 'C'
	  puts "read pos neg symbol"
	elsif "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "token finished"
	  state = startState(char)
	end
  elsif state == 'C'
    if "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "token finished"
	  state = startState(char)
	end
  elsif state == 'r'
    if "1234567890".include?(char)
	  state = 'r'
	  puts "read digit"
	else 
	  puts "token finished"
	  state = startState(char)
    end
  else
       puts "token finished"
	  state = startState(char)
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


