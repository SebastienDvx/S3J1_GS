require 'nokogiri'
require 'open-uri'

def scrapper_for_dummies(url, path)
  page = Nokogiri::HTML(open(url))
  return page.css(path)
end

def get_emails_from_all_towns_in_dpt(url_path)
    infos = Hash.new
    url = $base_url + url_path
    towns = scrapper_for_dummies(url, "a.lientxt")
    towns[0..2].each do |town|      # Supprimer le [0..2] pour scrapper toutes les mairies.
        town_name = town['href'][2..-6].gsub(/\d+\//, '')
        infos[town_name] = { email: get_the_email_of_a_townhall_from_its_webpage(town['href']) }
    end
    return infos
end

def get_infos_of_a_townhall_from_its_webpage(url_rpath)
  url = "#{$base_url}#{url_rpath}"
  infos = scrapper_for_dummies(url, 'p.Style22 > font')
  return infos
end

def get_the_email_of_a_townhall_from_its_webpage(url_rpath)
  url = "#{$base_url}#{url_rpath}"
  infos = scrapper_for_dummies(url, 'p.Style22 > font')
  email = infos[10].text.gsub!(/[[:space:]]/, '') # &nbsp = \xA0 = /[[:space:]]/
  return email
end
