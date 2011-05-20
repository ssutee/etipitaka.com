# == Schema Information
# Schema version: 20110520135313
#
# Table name: links
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Link < ActiveRecord::Base
  attr_accessible :title, :url, :description
end
