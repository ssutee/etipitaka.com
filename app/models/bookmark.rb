# == Schema Information
# Schema version: 20110513120758
#
# Table name: bookmarks
#
#  id          :integer         not null, primary key
#  note        :text
#  user_id     :integer
#  page_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  item_number :integer
#

class Bookmark < ActiveRecord::Base
  attr_accessible :note, :page_id, :user_id, :item_number, :created_at, :updated_at
  belongs_to :user
  belongs_to :page

  default_scope :order => 'bookmarks.created_at DESC'
end
