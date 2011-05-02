# == Schema Information
# Schema version: 20110502011238
#
# Table name: items
#
#  id         :integer         not null, primary key
#  begin      :boolean
#  number     :integer
#  section    :integer
#  page_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Item < ActiveRecord::Base
  attr_accessible :begin, :number, :section

  belongs_to :page

  validates :begin, :presence => true
  validates :number, :presence => true
  validates :section, :presence => true
end
