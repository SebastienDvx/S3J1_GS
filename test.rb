require 'google_drive'

session = GoogleDrive::Session.from_config("config.json")
p session

ws = session.spreadsheet_by_key("1NkYULhKvoOrsp9u1BXkYpRJS5G-InYP0HhlY87csgls").worksheets[0]
p ws[1, 1]
