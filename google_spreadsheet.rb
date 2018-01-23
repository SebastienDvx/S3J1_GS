require_relative 'scrap_mairies'
require 'google_drive'

$base_url = "http://annuaire-des-mairies.com/"

def write_in_ws(infos)
# Initialisation de la session GoogleDrive et du classeur
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1NkYULhKvoOrsp9u1BXkYpRJS5G-InYP0HhlY87csgls").worksheets[0]

# Efface toutes les données du classeur avant de relancer la méthode
ws.delete_rows(1, ws.num_rows) # num_rows va chercher la dernière ligne non vide
# Initialise les en-têtes des colonnes
ws[1,1] = "Villes"
ws[1,2] = "Adresses mail"
ws.save

# Utilisation du résultat du scrapper pour récupérer en entrée : un hash
  infos = get_emails_from_all_towns_in_dpt("val-d-oise.html")
# Boucler sur ce hash en récupérant 2 infos : 1 ligne et 1 n° de ligne
  infos.each_with_index do |item, row_index|
    row = Array.new(1, item[0])
    # p row
    row += item[1].values
    row_index = row_index + 2
    ws.insert_rows(row_index, [row])
  end
# Sauvegarder le bordel
ws.save
end

# Appel de la fonction
write_in_ws(get_emails_from_all_towns_in_dpt("val-d-oise.html"))
