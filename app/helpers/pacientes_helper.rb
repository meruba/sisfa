module PacientesHelper

	def age(date)
		birthday = date
		now = Time.now.utc.to_date
		now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

	def exact_age(birthday)
		y=(Date.today.year) - (birthday.year)
		m=(Date.today.month)-(birthday.month)
		d=(Date.today.day)-(birthday.day)
		tipo=""
	case 
	when (m<0) 
		age= (y-1).to_s + " años"
	when (m==0)
		if y==0
			age=d.to_s + " dias" #recien nacido menos de 1 mes del año actual
		else
			age=y.to_s + " años"	
		end
	when (m>0)
		if y==0
			age=m.to_s + " meses" # recien nacido mayor a 1 mes del año actual
		else	
			age=y.to_s + " años"
		end
	end
	age
	end
end
