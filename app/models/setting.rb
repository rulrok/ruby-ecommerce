class Setting < ActiveRecord::Base

  def self.obtain (key)
    Setting.find_by_key(key).value || nil
  end
end