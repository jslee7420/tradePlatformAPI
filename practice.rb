# 주어진 문자열로 만들 수 있는 모든 substring 배열 리턴
def makeSubstring(str)
  len = str.length
  @substrings = []
  (0...len).each do |i|
    (i...i + 3).each do |j|
      if j >= len
        next
      end
      @substrings.append(str[i..j])
    end
  end
  @substrings
end

puts makeSubstring("abcd")

def hello
  sub = []

  sub += makeSubstring("ab")
  sub += makeSubstring("cd")

  sub.each do |str|
    print str + " "
  end
end
