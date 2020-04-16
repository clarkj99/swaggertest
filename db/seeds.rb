require "csv"
User.destroy_all
puts "Importing Users data ..."

csv_text = File.path(Rails.root.join("db", "users.csv"))

count = 1
CSV.foreach(csv_text) do |row|
  # skip the header row
  User.create(email: row[1], name: row[2], github_username: row[3], registered_at: row[4]) if count > 1
  count += 1
  if (count % 100) == 0
    puts count
  end
end
puts "Imported #{count} Users"
