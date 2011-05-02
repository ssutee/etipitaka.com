# == Schema Information
# Schema version: 20110502011238
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  language   :string(255)
#  number     :integer
#  content    :text
#  volume     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base
  attr_accessible :language, :number, :content, :volume

  has_many :items

  validates :language, :presence => true, :allow_blank => false,
                       :inclusion => { :in => %w(thai pali) }
  validates :number,   :presence => true
  validates :content,  :presence => true, :allow_blank => false
  validates :volume,   :presence => true
end
