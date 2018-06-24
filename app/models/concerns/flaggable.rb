module Flaggable 
  def self.included(base)
    base.has_one :flag, as: :flaggable
  end

  def flag!
    flag = Flag.new(flaggable: self)
    flag.save
  end

  def unflag!
    binding.pry
    flag = Flag.find_by(flaggable: self)
    flag.destroy
  end

  def flagged?
     Flag.exists?(flaggable: self)
  end
end