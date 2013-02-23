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
  has_many :bookmarks

  validates :language, :presence => true, :allow_blank => false,
                       :inclusion => { :in => %w(thai pali) }
  validates :number,   :presence => true
  validates :content,  :presence => true, :allow_blank => false
  validates :volume,   :presence => true

  default_scope :order => 'pages.volume ASC, pages.number ASC'

  def self.max(language, volume)
    where("language = ? AND volume = ?",language, volume).count 
  end

  def self.all_pages(language, volume)
    select("content").where("language = ? AND volume = ?",language, volume)
  end

  def self.content(language, volume, number)
    pages = where("language = ? AND volume = ? AND number = ?",language, volume, number)
    pages.empty? ? nil : pages.first.content
  end

  def self.search(language, volume, keywords)
    cmd = 'language = :language AND volume = :volume'
    keywords.split.each do |w|
      cmd << " AND content LIKE '%#{w.gsub('+',' ')}%'" 
    end
    where(cmd, { :language => language, :volume => volume })
  end

  def self.search_all(language, keywords)
    cmd = 'language = :language'
    keywords.split.each do |w|
      cmd << " AND content LIKE '%#{w.gsub('+',' ')}%'" 
    end
    where(cmd, { :language => language })
  end
end
