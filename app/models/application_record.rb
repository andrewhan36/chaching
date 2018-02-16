class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  after_initialize :default_values
  def default_values
	self.uuid = SecureRandom.uuid if has_attribute? :uuid and self.uuid.nil?
  end
end
