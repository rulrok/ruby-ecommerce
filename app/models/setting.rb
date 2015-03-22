class Setting < ActiveRecord::Base
  def self.obtain(key)
    setting = Setting.find_by_key(key) || nil
    if setting.nil?
      ''
    else
      setting.value
    end
  end
end
