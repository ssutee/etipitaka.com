# == Schema Information
# Schema version: 20110513050021
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  note       :text
#  user_id    :integer
#  page_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Bookmark < ActiveRecord::Base
  attr_accessible :note, :page_id, :user_id
  belongs_to :user
  belongs_to :page
end
