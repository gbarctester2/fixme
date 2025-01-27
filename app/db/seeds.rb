User.find_or_create_by!(name: 'A', email: 'a@aol.com', login: 'aa')
User.find_or_create_by!(name: 'B', email: 'b@aol.com', login: 'bb')
User.first_or_create(name: 'C', email: 'c@aol.com', login: 'cc')
