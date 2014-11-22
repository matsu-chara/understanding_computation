require './rules.rb'

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_nfa
    NFA.new(Set[start_state], accept_states, rulebook)
  end

  def accepts?(string)
    to_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
  end
end

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  def accepting?
    (current_states & accept_states).any?
  end

  def read_character(character)
    self.current_states = rulebook.next_states(current_states, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

# rulebook = NFARuleBook.new([
#   FARule.new(1, 'a', 1), FARule.new(1, 'b', 1), FARule.new(1, 'b', 2), FARule.new(1, 'b', 2),
#     FARule.new(2, 'a', 3), FARule.new(2, 'b', 3),
#     FARule.new(3, 'a', 4), FARule.new(3, 'b', 4)
# ])
# nfa_design = NFADesign.new(1, [4], rulebook)
# p nfa_design.accepts?('bab')
# p nfa_design.accepts?('bbbbb')
# p nfa_design.accepts?('bbabb')
