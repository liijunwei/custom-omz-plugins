# gitlab -> profile -> inspect -> find “js-contrib-calendar” -> copy calendar svg
# github will be the same

# TODO get the svg file automatically

require 'nokogiri'
require 'json'
require 'date'

class GitlabContribCalendarParser
  def run(filepath)
    html = File.read(filepath)
    parsed_data = Nokogiri::HTML.parse(html)
    result = []

    parsed_data.search('svg g rect').each do |node|
      next if node.attributes["data-original-title"].nil?
      result << get_info(node)
    end

    result
  end

  private

  def split_str
    @cached_str ||= "\n      <br />"
  end

  def get_info(node)
    element = node.attributes["data-original-title"].value.split(split_str)

    hash = {}
    hash[:data_date]  = Date.parse(element[1])
    hash[:data_count] = element[0].to_i
    hash[:data_level] = node.attributes["fill"].value

    hash
  end
end
