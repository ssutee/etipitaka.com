# == Schema Information
# Schema version: 20110520140515
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :title, :content, :created_at
end
