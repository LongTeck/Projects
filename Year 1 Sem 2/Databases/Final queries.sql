select p.PgrName as 'Passenger Name', isnull(count(bookingID),0) as 'No. of Bookings', isnull(count(reservID),0) as 'No. of Reservations' 
from passenger p inner join booking b on p.PgrID = b.PgrID inner join Reservation r on r.PgrID = p.PgrID group by p.PgrName

select EatyName, sum(Price), count(pgrid) from Eatery e inner join Dish d on e.EatyID = d.EatyID inner join CSDish cs on d.DishID = cs.DishID inner join orders o on cs.DishID = o.DishID
group by EatyName order by sum(price) desc

select FcName, FcDescr, count(e.eatyid) from FoodCategory fc inner join categorised_in ci on fc.FcID = ci.FcID inner join dish d on d.dishid = ci.dishid 
inner join eatery e on d.EatyID = e.EatyID group by fcname, FcDescr