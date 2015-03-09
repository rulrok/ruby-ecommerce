class Setting < ActiveRecord::Base
  attr_accessor :key

  public

  def self.obtain (key)
    Setting.find_by_key(key).value || nil
  end
end