Author.connection.execute('ALTER SEQUENCE authors_id_seq RESTART WITH 1')
Publisher.connection.execute('ALTER SEQUENCE publishers_id_seq RESTART WITH 1')
Book.connection.execute('ALTER SEQUENCE books_id_seq RESTART WITH 1')

load 'db/seeds/destroy_all.rb'
load 'db/seeds/authors.rb'
load 'db/seeds/publishers.rb'
load 'db/seeds/books.rb'
