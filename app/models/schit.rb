class Schit 

	include DataMapper::Resource

		property :id, Serial
		property :message, Text
		property :time_stamp, Time

    has 1, :user, :through => Resource 

   # 	has n, :responses, :child_key => [ :source_id ]
 		# belongs_to :original,  self, :required => false #Top level comments have none.

end