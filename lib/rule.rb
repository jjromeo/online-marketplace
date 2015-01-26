class Rule
  attr_reader :type

  def apply
    raise 'this rule has no effect'
  end

end
