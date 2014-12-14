puts 'hello world'
program = "puts 'hello world'"
bytes_in_binary = program.bytes.map { |byte| byte.to_s(2).rjust(8, '0') }
number = bytes_in_binary.join.to_i(2)
p number # rubyプログラムの数字表現 rubyプログラム番号

# rubyプログラム番号をコードに変換して実行
number = 9796543849500706521102980495717740021834791
bytes_in_binary = number.to_s(2).scan(/.+?(?=.{8}*\z)/)
program = bytes_in_binary.map { |string| string.to_i(2).chr }.join
p program
eval program
