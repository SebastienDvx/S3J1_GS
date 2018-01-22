require_relative 'scrap_mairies'
require 'google_drive'

$base_url = "http://annuaire-des-mairies.com/"

def write_in_ws(infos)
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1NkYULhKvoOrsp9u1BXkYpRJS5G-InYP0HhlY87csgls").worksheets[0]

ws[1,1] = "Villes"
ws[1,2] = "Adresses mail"
ws.save
  infos = get_emails_from_all_towns_in_dpt("val-d-oise.html")
  # p infos
  infos.each_with_index do |item, row_index|
    row = [item[0]] + item[1].values
    row_index = row_index + 2
    ws.insert_rows(row_index, [row])
  end
ws.save
end



write_in_ws(get_emails_from_all_towns_in_dpt("val-d-oise.html"))
