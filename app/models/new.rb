# == Schema Information
# Schema version: 20110520135313
#
# Table name: news
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class New < ActiveRecord::Base
  attr_accessible :title, :content, :created_at
end
