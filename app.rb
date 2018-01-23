require_relative 'gmail'
require_relative 'scrap_mairies'


def get_rows_from_items(items)
  items.map { |item| [item[0]] + item[1].values }
end


# destinataires = ["jean25pierre2@gmail.com","jeanmichelcodeur@gmail.com"]
# destinataires = get_emails_from_all_towns_in_dpt("val-d-oise.html")
destinataires = get_rows_from_items(get_emails_from_all_towns_in_dpt("val-d-oise.html"))

# p destinataires

destinataires = destinataires.map{ |row| row[1]}
p destinataires
send_emails(destinataires)
