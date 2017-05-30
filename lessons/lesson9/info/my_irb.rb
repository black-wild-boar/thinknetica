line_num = 0
code = ''

loop do
  print "#{line_num += 1}?: "
  line = gets
  break if line.strip == 'exit'

  if line.strip == ''
    p 'Evaluationg...'
    p eval(code)
    code = ''
  else
    code += line
  end
end