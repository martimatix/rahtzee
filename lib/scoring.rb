module Scoring # methods for calculating score

	UpperScores = :ones, :twos, :threes, :fours, :fives, :sixes	# The fields on the top section of the score sheet
	
	LowerScores = :three_of_a_kind, :four_of_a_kind, :full_house, :small_straight, :large_straight, :chance, :yahtzee  # The fields on the bottom section of the score sheet

=begin
@param dice [Array<Fixnum>] The dice to be tested
Checks to see if dice has 3 of one kind of dice and 2 of another
@return [Fixnum] 25 if dice contains 3 of one Fixnum and 2 of another
@return [Fixnum] 0 if dice does not contain 3 of one Fixnum and 2 of another
=end
	def full_house(dice)
		f_table = freq dice
		if (f_table.length == 2 && f_table.has_value?(3)) || f_table.length == 1 then 25			
		else 0 end
	end
	
=begin
@param dice [Array<Fixnum>] The dice to be tested
Checks to see if you have 4 of the same dice
@return [Fixnum]  0 if <= 4 indices have the same value
@return [Fixnum]  dice.reduce(:+) if >= 4 indices have the same value
@see (three_of_a_kind)
=end
	def four_of_a_kind(dice)
		of_a_kind dice, 4
	end

	def rahtzee(dice)
		of_a_kind dice, 5
	end

=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the total of all the ones
=end
	def ones(d)
		single_face d, 1
	end

=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the total of all the twos
=end
	def twos(d)
		single_face d, 2
	end

=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the score
=end
	def threes(d)
		single_face d, 3
	end 

=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the score
=end
	def fours(d)
		single_face d, 4
	end
	
=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the score
=end
	def fives(d)
		single_face d, 5
	end

=begin
@param d [Array<Fixnum>] the dice to be tested
@return [Fixnum] the score
=end
	def sixes(d)	# @see (#ones)
		single_face d, 6
	end

=begin
@see (#four_of_a_kind)
Checks to see if you have 3 of the same dice
@return [Fixnum] dice.reduce(:+) if there is <= 3 of the same value
@return [Fixnum] 0 if you do not have a three of a kind
=end
	def three_of_a_kind(dice)
		of_a_kind dice, 3
	end

=begin
@param dice [Array<Fixnum>] the dice to be evaluated
@return [Fixnum] the sum of all the dice
=end
	def chance(dice)
		dice.reduce :+
	end

=begin
@param dice [Array<Fixnum>] the dice to be tested
@return [Fixnum] 30 if there are 3 consecutive Fixnums in dice
@return [Fixnum] 0 if there are not three conscecutive Fixnums in dice
@see (large_straight)
=end
	def small_straight(dice)
		straight dice, 4, 30
	end
	alias SS small_straight
	
=begin
@param dice [Array<Fixnum>] the dice to be tested
@return [Fixnum] 40 if there are 4 consecutive Fixnums in dice
@return [Fixnum] 0 if there are not three conscecutive Fixnums in dice
@see (small_straight)
=end
	def large_straight(dice)
		straight dice, 5, 40
	end
	alias LS large_straight
	
	private # Helper methods for score calculation

	def single_face(dice, value)
	 	v = dice.select{|number| number == value}.reduce :+
	 	unless v.nil? then  v
		else 0 end
	end

	def freq(dice)
		dice.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	end

	def modal_frequency(dice)
		freq(dice).max_by{|k,v| v}[1]
	end 

	def of_a_kind(dice, limit)
		if modal_frequency(dice) >= limit then dice.reduce :+
		else 0 end
	end

=begin	
@param dice [Fixnum] the dice to be tested
@param limit [Fixnum] = 4 for small straight
@param limit [Fixnum] = 5 for large straight
common code for both small straight (SS) and large straight (LS)
@param score [Fixnum] is the score to return
@return [Fixnum] score
=end
	def straight(dice, limit, score) 
		(1..6).each_cons(limit).each do |i| #each_cons is generating every possible value for a straight of length limit
			if (i - dice).empty? # Asking if i is a subset of dice
				return score if (i - dice)
			end
		end
		0
	end
end
