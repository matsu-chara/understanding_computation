require 'treetop'
require './pattern.rb'

Treetop.load('regexp')

parse_tree = PatternParser.new.parse('(a(|b))*')
p parse_tree

pattern = parse_tree.to_ast
p pattern

p pattern.matches? 'abaab'

p pattern.matches? 'abba'
