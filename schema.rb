# database setup
DataMapper.setup(:default, 'mysql://root:43rscm2uD@localhost/vineyard')

class User
	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true
	property :fb_id, Integer # one's Facebook ID, if applicable
	property :admin, Boolean, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime

	has n, :posts
	has n, :comments
end

class Post
	include DataMapper::Resource

	property :id, Serial
	property :title, String, :required => true
	property :body, Text, :required => true
	property :created_at, DateTime
	property :updated_at, DateTime

	belongs_to :user
	has n, :comments
end

class Comment
	include DataMapper::Resource

	property :id, Serial
	property :author, String # reserved for if the user wishes to post anonymously
	property :body, Text, :required => true
	property :created_at, DateTime
	property :updated_at, DateTime

	belongs_to :user
	belongs_to :post
end

DataMapper.finalize.auto_upgrade! # automatically create tables and columns