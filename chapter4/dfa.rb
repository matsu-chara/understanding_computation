require './rules.rb'

class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_dfa
    DFA.new(start_state, accept_states, rulebook)
  end

  def accepts?(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end

class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

# rulebook = DFARulebook.new([
#     FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
#     FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
#   FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
# ])
# dfa_design = DFADesign.new(1, [3], rulebook)
# p dfa_design.accepts? 'a'
# p dfa_design.accepts? 'baa'
# p dfa_design.accepts? 'baba'
