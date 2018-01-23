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
    towns[0..2].each do |town|
    # towns[0..10].each do |town| #XXX: pour éviter d'être "noyer" par l'affichage de toutes les valeurs
        town_name = town['href'][2..-6].gsub(/\d+\//, '')
        infos[town_name] = { email: get_the_email_of_a_townhall_from_its_webpage(town['href']) }
        # puts "[DEBUG] #{town_name} #{$base_url + town['href']}"
    end
    return infos
end

def get_infos_of_a_townhall_from_its_webpage(url_rpath)
  # puts "\n[DEBUG] All informations extracted from city homepage :"
  # puts "-------------------------------------------------------"
  url = "#{$base_url}#{url_rpath}"
  infos = scrapper_for_dummies(url, 'p.Style22 > font')
  # infos.each { |item| puts "[DEBUG] #{item.text}" }
  return infos
end

def get_the_email_of_a_townhall_from_its_webpage(url_rpath)
  # puts "\n[DEBUG] email from city homepage"
  url = "#{$base_url}#{url_rpath}"
  infos = scrapper_for_dummies(url, 'p.Style22 > font')
  # infos.select{ |item| item.children[0].text.include? "@" }
  email = infos[10].text.gsub!(/[[:space:]]/, '') # &nbsp = \xA0 = /[[:space:]]/
  # puts "[DEBUG] extracted: '#{email}' (clean = without spaces)"
  return email
end
