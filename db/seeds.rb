# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

class String
  def thai_to_i
    self.gsub('๐','0').
      gsub('๑','1').
      gsub('๒','2').
      gsub('๓','3').
      gsub('๔','4').
      gsub('๕','5').
      gsub('๖','6').
      gsub('๗','7').
      gsub('๘','8').
      gsub('๙','9').to_i
  end
end

def quote (str)
  str.gsub("\\","\\\\\\\\").gsub("'","\\\\'")
end

for lang in ['thai','pali'] do
  dirs = File.join("**", lang, "**")
  Dir.glob(dirs).each do |dir|
    prev_tmp = ['0']
    items_tmp = []
    files = File.join(dir, "**")
    Dir.glob(files).each do |file|
      f = File.split(file)[-1]
      volume = f[(0..1)].to_i
      number = f[(2..5)].to_i
      tmp = []
      content = File.open(file, "r").read
      content = content.gsub('x',' ').gsub('X',' ')
      File.open(file, "r") do |infile|
        while line = infile.gets
          if line =~ /^\s*\[([๐๑๒๓๔๕๖๗๘๙]+?)\](.*)/ 
            if !$2.strip.empty?
              tmp << $1.thai_to_i.to_s
            end
          end
        end
        if tmp.empty?
          items = prev_tmp[-1] 
          marked = false
        else
          items = tmp.join(' ')
          prev_tmp = tmp
          marked = true
        end
        puts "create a page: language = #{lang} volume = #{volume} number = #{number} "
        page = Page.create!(:language => lang, :volume => volume, :number => number, :content => quote(content))
        items.split.each do |item|
          if items_tmp.empty? or item != items_tmp[-1]
            items_tmp << item 
          end
          if item == '0'
            sub = 1 
          else
            sub = items_tmp.count('1')
          end
          # puts "create an item: begin = #{marked} number = #{item.to_i} section = #{sub} " 
          page.items.create!(:begin => marked, :number => item.to_i, :section => sub)
        end
      end
    end
  end
end
