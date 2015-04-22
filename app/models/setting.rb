class Setting < ActiveRecord::Base
  validates :key, presence: true

  def self.obtain(key)
    setting = Setting.find_by_key(key) || nil
    if setting.nil?
      ''
    else
      setting.value
    end
  end
end
