require "./tagsystem.rb"

class CyclicTagRule < TagRule
  FIRST_CHARACTER = '1'

  def initialize(append_characters)
    super(FIRST_CHARACTER, append_characters)
  end

  def inspect
    "#<CyclicTagRule #{append_characters.inspect}>"
  end
end

class CyclicTagRulebook < Struct.new(:rules)
  DELETION_NUMBER = 1

  def initialize(rules)
    super(rules.cycle)
  end

  def applies_to?(string)
    string.length >= DELETION_NUMBER
  end

  def next_string(string)
    follow_next_rule(string).slice(DELETION_NUMBER..-1)
  end

  def follow_next_rule(string)
    rule = rules.next

    if rule.applies_to?(string)
      rule.follow(string)
    else
      string
    end
  end
end

class TagRule
  def alphabet
    ([first_character] + append_characters.chars.entries).uniq
  end
end

class TagRulebook
  def alphabet
    rules.flat_map(&:alphabet).uniq
  end

  def cyclic_rules(encoder)
    encoder.alphabet.map { |character| cycle_rule_for(character, encoder) }
  end

  def cyclic_rule_for(character, encoder)
    rule = rule_for(charcter)

    if rule.nil?
      CyclicTagRule.new('')
    else
      rule.to_cyclic(encoder)
    end
  end

  def cyclic_padding_rules(encoder)
    Array.new(encoder.alphabet.length, CyclicTagRule.new('')) * (delettion_number - 1)
  end

  def to_cyclic(encoder)
    CycleTagRulebook.new(cyclic_rules(encoder) + cyclic_padding_rules(encoder))
  end
end

class CyclicTagEncoder < Struct.new(:alphabet)
  def encode_string(string)
    string.chars.map { |character| encode_character(character) }.join
  end

  def encode_character(character)
    character_position = alphabet.index(character)
    (0..alphabet.length).map { |n| n == character_position ? '1' : '0' }.join
  end
end

class TagSystem
  def alphabet
    (rulebook.alphabet + current_string.chars.entries).uniq.sort
  end

  def encoder
    CyclicTagEncoder.new(alphabet)
  end

  def to_cyclic
    TagSystem.new(encoder.encode_string(current_string), rulebook.to_cyclic(encoder))
  end
end

class TagRule
  def to_cyclic(encoder)
    CyclicTagRule.new(encoder.encode_string(append_characters))
  end
end
