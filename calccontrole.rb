module Control
	def throttle_angle_to_thrust(r, theta)
		theta = ((theta + 180) % 360) - 180  # normalize value to [-180, 180)
		r = [[0, r].max, 100].min              # normalize value to [0, 100]
		v_a = r * (45 - theta % 90) / 45          # falloff of main motor
		v_b = [100, 2 * r + v_a, 2 * r - v_a].min  # compensation of other motor
		return [-v_b, -v_a] if theta < -90
		return [-v_a, v_b] if theta < 0
		return [v_b, v_a] if theta < 90
		return [v_a, -v_b]
	end
end



if __FILE__ == $0 then
	(0..10).each do |e|
		puts "R: ", e*10
		puts ((-36)..36).inject("") do |add,atual|
			add.concat(" "+throttle_angle_to_thrust(e*10,atual*5).to_s)
		end
	end
end