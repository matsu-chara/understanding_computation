$ones_place = ["ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE"]
$tens_place = ["TEN", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY", "SEVENTY", "EIGHTY", "NINETY"]
$teenagers = ["ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN"]

def num_in_english_under100(mod)
  output = []
  # 10以上99以下を変換
  if mod >= 10
    div, mod = mod.divmod(10)
    if div > 0
      if div ==1 && mod > 0
        #11以上19以下
        output << $teenagers[mod -1]
        return output
      else
        #10、20以上99以下
        output << $tens_place[div -1]
      end
    end
  end

  # 1以上9以下を変換
  if mod > 0
    output << $ones_place[mod -1]
  end
  output.join("_")
end

res =  (1..100).map do |n|
  a = [num_in_english_under100(n)]
  b = [' = -> p { -> x { ']

  c = (1..n).map do |_|
    'p['
  end

  d = ['x']

  e = (1..n).map do |_|
    ']'
  end

  f = ['} }']

  (a + b + c + d + e + f).join
end
puts res.join("\n")
