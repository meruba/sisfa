module PacientesHelper

def age(date)
	birthday = date
  now = Time.now.utc.to_date
  now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
end

end
