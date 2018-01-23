require 'gmail'
require_relative 'password'
require_relative 'google_spreadsheet'


# Ton username pour te connecter à ton compte gmail
def connection(username)
  password = get_mdp
  gmail = Gmail.connect(username, password)
  return gmail
end

# Définition de la méthode send_email.
def send_email(gmail, destinataire)
  email = gmail.compose do
    to "#{destinataire}"
    subject "TEST TEST"
    body "18:55"
  end
  email.deliver!
  puts "email sent !"
end

def send_emails(destinataires)
  destinataires.each do |destinataire|
    send_email($gmail, destinataire)
  end
end

$gmail = connection("sebdoe75@gmail.com")

# send_email(gmail, "sebdoe75@gmail.com")
# send_emails(gmail, ["sebdoe75@gmail.com","jeanmichelcodeur@gmail.com"])
# send_emails(gmail, liste_dest)

# send_emails(["sebdoe75@gmail.com","jeanmichelcodeur@gmail.com"])
