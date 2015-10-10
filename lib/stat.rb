class Stat
	attr_accessor :type, :hp, :ms, :as, :ad
	def initialize(type = :mortal, hp = 3, ms = 5, as = 2.0, ad = 3)
		@type = type	# mortal/immortal
		@hp = hp		# hit points
		@ms = ms		# movement speed
		@as = as		# attack speed
		@ad = ad		# attack damage
	end
end
