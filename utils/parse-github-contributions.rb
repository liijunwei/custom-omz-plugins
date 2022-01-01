# github -> profile -> inspect -> find “js-contrib-calendar” -> copy calendar svg
# github will be the same

# TODO get the svg file automatically

require 'nokogiri'
require 'json'

class GithubContribCalendarParser
  def run(filepath)
    html = File.read(filepath)
    parsed_data = Nokogiri::HTML.parse(html)
    result = []

    parsed_data.search('svg g rect').each do |node|
      result << get_info(node)
    end

    result
  end

  private

  def get_info(node)
    hash = {}
    hash[:data_date]  = node.attributes["data-date"].value
    hash[:data_count] = node.attributes["data-count"].value.to_i
    hash[:data_level] = node.attributes["data-level"].value

    hash
  end
end
