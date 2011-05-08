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

  validates :number, :presence => true
  validates :section, :presence => true

  def self.max(language, volume, section)
    page_ids = %(SELECT id FROM pages WHERE language = :language AND volume = :volume) 
    items = where("page_id IN (#{page_ids}) AND section = :section AND begin = 't'", 
      { :language => language, :volume => volume, :section => section })
    items.map(&:number).max
  end

  def self.content(language, volume, section, number)
    page_ids = %(SELECT id FROM pages WHERE language = :language AND volume = :volume) 
    items = where("page_id IN (#{page_ids}) AND section = :section"+
                  " AND begin = 't' AND number = :number", 
      { :language => language, :volume => volume, 
        :section => section, :number => number })
    items.empty? ? nil : Page.find(items.first.page_id).content
  end
end
