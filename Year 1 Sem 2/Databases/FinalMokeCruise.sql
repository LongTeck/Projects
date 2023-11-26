create database monkecruise

CREATE TABLE Passenger
(
PgrID smallint primary key,
PgrName varchar(50) not null,
PgrEmail varchar(50) null,
PgrDOB smalldatetime not null,
PgrGender char(1) not null check(PgrGender in ('M','F')),
CabinNo smallint not null
)

CREATE TABLE PgrContactNo
(
PgrID smallint not null,
PgrContactNo char(10) not null,
Constraint PK_PgrContactNo PRIMARY KEY (PgrID, PgrContactNo),
Constraint FK_PgrContactNo_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID)
)

CREATE TABLE Eatery
(
EatyID smallint primary key, 
EatyName varchar(50) not null,
EatyLoc varchar(50) not null,
EatyCapacity tinyint not null,
EatyOpHr time not null,
EatyClHr time not null
)


CREATE TABLE Reservation
(
ReservID int primary key,
ReservStatus char(1) not null check(ReservStatus in ('B', 'P', 'C')),
ReservDateTime smalldatetime not null,
RequiredDateTime smalldatetime not null,
NoOfPax tinyint not null,
PgrID smallint not null,
EatyID smallint not null,
Constraint FK_Reservation_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
Constraint FK_Reservation_EatyID FOREIGN KEY (EatyID) REFERENCES Eatery(EatyID),
Constraint ck_requireddatetime check(RequiredDateTime > ReservDateTime)
)

CREATE TABLE EventType
(
ETID smallint primary key,
ETName varchar(50) not null
)

CREATE TABLE Event
(
EventID smallint primary key,
EventName varchar(50) not null,
EventDescr varchar(200) null,
EventLoc varchar(100) not null,
EventCapacity smallint not null,
EventDuration float not null,
ChildPrice smallmoney null,
AdultPrice smallmoney null,
MinAge tinyint null,
MaxAge tinyint null,
ETID smallint not null,
Constraint FK_Event_ETID FOREIGN KEY (ETID) REFERENCES EventType(ETID)
)

CREATE TABLE EventSession
(
SessionNo smallint,
EventDateTime smalldatetime not null,
EventID smallint not null,
Constraint PK_SessionNo PRIMARY KEY (SessionNo, EventID),
Constraint FK_EventSession_EventID FOREIGN KEY (EventID) REFERENCES Event(EventID)
)

CREATE TABLE Booking
(
BookingID int primary key,
BookStatus char(1) not null check(BookStatus in ('B', 'P', 'C')),
BookDateTime smalldatetime not null,
NoOfChildTicket smallint not null,
NoOfAdultTicket smallint not null,
ChildSalesPrice smallmoney null,
AdultSalesPrice smallmoney null,
PgrID smallint not null,
EventID smallint not null,
SessionNo smallint not null,
Constraint FK_Booking_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
Constraint FK_Booking_SessionNo FOREIGN KEY (SessionNo, EventID) REFERENCES EventSession(SessionNo, EventID)
)


CREATE TABLE Ingredient
(
IngredID smallint primary key,
IngredName varchar(50) not null
)

CREATE TABLE Cuisine
(
cuisineID smallint primary key,
cuisineName varchar(50) not null
)

CREATE TABLE Dish
(
DishID smallint primary key,
DishName varchar(50) not null,
DishDescr varchar(200) not null,
cuisineID smallint not null,
EatyID smallint not null,
Constraint FK_Dish_EatyID FOREIGN KEY (EatyID) REFERENCES Eatery(EatyID),
Constraint FK_Dish_cuisineID FOREIGN KEY (cuisineID) REFERENCES Cuisine(cuisineID)
)

CREATE TABLE FoodCategory
(
FcID smallint primary key,
FcName varchar(50) not null,
FcDescr varchar(100) not null
)

CREATE TABLE contain
(
IngredID smallint not null,
DishID smallint not null,
Constraint FK_contain_IngredID FOREIGN KEY (IngredID) REFERENCES Ingredient(IngredID),
Constraint FK_contain_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID),
Constraint PK_contain_IngredID PRIMARY KEY (IngredID, DishID)
)

CREATE TABLE categorised_in
(
FcID smallint not null,
DishID smallint not null,
Constraint FK_categorised_in_FcID FOREIGN KEY (FcID) REFERENCES FoodCategory(FcID),
Constraint FK_categorised_in_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID),
Constraint PK_categorised_in_category PRIMARY KEY (FcID, DishID)
)

CREATE TABLE orders
(
PgrID smallint not null,
DishID smallint not null,
OrderDateTime smalldatetime not null,
DelDateTime smalldatetime not null,
OrderQty smallint not null,
OrderPrice smallmoney not null,
DeliverTo smallint not null,
Constraint FK_orders_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
Constraint FK_orders_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID),
Constraint PK_orders_order PRIMARY KEY (OrderDateTime, PgrID, DishID)
)

CREATE TABLE CSDish
(
DishID smallint not null,
Price smallmoney not null,
Constraint PK_CSDish_DishID PRIMARY KEY (DishID),
Constraint FK_CSDish_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID)
)


/* Insert */
Insert into Passenger values(001, 'Joe Mama', 'joemama@yahoo.com', '2001/10/01', 'F', 001)
Insert into Passenger values(002, 'Daddy Joe', 'daddyjoe@gmail.com', '1998/01/15', 'M', 001)
Insert into Passenger values(003, 'Brother Joe', 'brotherjoe@gmail.com', '2004/08/06', 'M', 001)
Insert into Passenger values(004, 'Sister Joe', null, '2005/12/12', 'F', 001)
Insert into Passenger values(005, 'Tiny Joe', null, '2006/01/31', 'M', 001)

Insert into Passenger values(006, 'Wei Ming', 'weiming@gmail.com', '1995/05/06', 'M', 002)
Insert into Passenger values(007, 'Giselle', 'giselle@gmail.com', '1995/08/13', 'F', 002)

Insert into Passenger values(008, 'Alvin', 'alvin@gmail.com', '1985/01/19', 'M', 003)
Insert into Passenger values(009, 'Marcus', 'marcus@yahoo.com', '1999/02/21', 'M', 003)
Insert into Passenger values(010, 'Maiden', 'maiden@gmail.com', '2000/10/05', 'F', 003)

Insert into Passenger values(011, 'Taryn', 'taryn@gmail.com', '2001/10/25', 'F', 004)
Insert into Passenger values(012, 'Allan', null, '2008/12/12', 'M', 004)
Insert into Passenger values(013, 'Hasin', 'hasin@gmail.com', '2000/11/26', 'M', 004)

Insert into Passenger values(014, 'Jun Dong', 'jd123456@gmail.com', '1995/05/16', 'M', 005)

Insert into Passenger values(015, 'Loner', '4everalone@yahoo.com', '2000/12/18', 'F', 006)

Insert into Passenger values(016, 'Yu Heang', 'moledage@gmail.com', '1999/10/19', 'M', 007)
Insert into Passenger values(017, 'Hanisah', 'tiktoker@gmail.com', '1999/06/19', 'F', 007)

Insert into Passenger values(018, 'Adlina', 'adlina@gmail.com', '1985/07/18', 'F', 008)

Insert into Passenger values(019, 'Friends', 'friend@gmail.com', '2001/01/01', 'M', 009)
Insert into Passenger values(020, 'Karen', 'karen@gmail.com', '1987/05/05', 'F', 009)
Insert into Passenger values(021, 'Ashley', 'ashley@gmail.com', '1984/08/21', 'F', 009)
Insert into Passenger values(022, 'Peter Kuan', 'peterkuan@yahoo.com', '1974/11/17', 'M', 009)

Insert into Passenger values(023, 'Siow Wee Koon', 'Siow@gmail.com', '1981/09/13', 'M', 010)
Insert into Passenger values(024, 'En Xian', null, '2008/11/09', 'M', 010)

Insert into Passenger values(025, 'Yue Qun', 'meinu@gmail.com', '1971/01/01', 'F', 011)

Insert into Passenger values(026, 'Gobhika', 'gobhika@yahoo.com', '1984/06/21', 'F', 012)
Insert into Passenger values(027, 'Ovia', 'naughty@yahoo.com', '1983/07/08', 'F', 012)
Insert into Passenger values(028, 'Andrea', 'blinking@yahoo.com', '1982/09/27', 'F', 012)

Insert into Passenger values(029, 'Foo Wee Leng', 'mathisawesome@gmail.com', '2000/06/03', 'F', 013)
Insert into Passenger values(030, 'Fiona Neo', 'chem@yahoo.com', '2000/07/13', 'F', 013)

Insert into Passenger values(031, 'Jordain Sim', 'jordain@gmail.com', '1995/05/21', 'M', 014)
Insert into Passenger values(032, 'Rasyirin', 'rasyirin@gmail.com', '1996/06/16', 'F', 014)
Insert into Passenger values(033, 'Anuksha', 'anuksha@gmail.com', '1996/08/08', 'F', 014)
Insert into Passenger values(034, 'Tricia', 'tricia@gmail.com', '1996/07/19', 'F', 014)
Insert into Passenger values(035, 'Shannon', 'shannon@gmail.com', '1996/10/15', 'F', 014)

Insert into Passenger values(036, 'Natania Ong', 'pepega@yahoo.com', '1985/10/10', 'F', 015)
Insert into Passenger values(037, 'Ardini', 'relax@yahoo.com', '1965/08/09', 'F', 015)

Insert into Passenger values(038, 'Yi Kai', 'yikai@gmail.com', '2000/03/05', 'M', 016)

Insert into Passenger values(039, 'Mary', 'mary@gmail.com', '1987/02/22', 'F', 017)

Insert into Passenger values(040, 'John Cena', 'invisible@gmail.com', '1985/03/26', 'M', 018)

Insert into Passenger values(041, 'Yan Zhen', 'yanzhen@gmail.com', '2000/02/15', 'M', 019)
Insert into Passenger values(042, 'Long Teck', 'longteck@gmail.com', '2001/03/08', 'M', 019)
Insert into Passenger values(043, 'Kendrew', 'kendy@gmail.com', '2002/07/23', 'M', 019)

Insert into Passenger values(044, 'Bryne', 'bryne@gmail.com', '2001/01/04', 'M', 020)
Insert into Passenger values(045, 'Amanda Ng', 'amanda@gmail.com', '2000/06/06', 'F', 020)

Insert into Passenger values(046, 'Han Ze', 'fei@gmail.com', '1998/09/11', 'M', 021)
Insert into Passenger values(047, 'Xin Yu', 'xinyu@gmail.com', '1987/12/24', 'M', 021)
Insert into Passenger values(048, 'Jun Yu', 'junyu@yahoo.com', '1986/07/21', 'M', 021)

Insert into Passenger values(049, 'Subaru', 'subaru@gmail.com', '1984/11/05', 'M', 022)
Insert into Passenger values(050, 'Emilia', 'emilia@gmail.com', '1984/12/07', 'F', 022)
Insert into Passenger values(051, 'Ram', 'ram@gmail.com', '1984/04/05', 'F', 022)
Insert into Passenger values(052, 'Rem', 'rem@gmail.com', '1984/09/17', 'F', 022)

Insert into Passenger values(053, 'Romeo', 'myRomeo@yahoo.com', '2004/01/01', 'M', 023)
Insert into Passenger values(054, 'Juliet', 'myJuliet@yahoo.com', '2004/01/15', 'F', 023)

Insert into Passenger values(055, 'Jason E. Martinez', 'jasonmartinez@gmail.com', '1991/08/06', 'M', 024)
Insert into Passenger values(056, 'Sharon D. Zubia', null, '2000/12/12', 'F', 024)

Insert into Passenger values(057, 'Timmy Lackey', null, '2006/01/31', 'M', 025)
Insert into Passenger values(058, 'Shouty Mouty', 'ahhhh123@gmail.com', '2003/05/06', 'M', 025)
Insert into Passenger values(059, 'Mrs Patson', 'sonPat@gmail.com', '1995/08/13', 'F', 025)
Insert into Passenger values(060, 'Mr Patdaughter', 'daughterPar@gmail.com', '1985/01/19', 'M', 025)
Insert into Passenger values(061, 'Smelly Kelly', 'sweetKelly@yahoo.com', '1999/02/21', 'F', 025)

Insert into Passenger values(062, 'Raiden Bogus', 'eternity4ever@gmail.com', '1980/08/05', 'F', 026)
Insert into Passenger values(063, 'Zong Lee', 'zonglee@gmail.com', '1980/10/25', 'M', 026)
Insert into Passenger values(064, 'Vent Lee', 'ehe@yahoo.com', '1980/04/18', 'M', 026)

Insert into Passenger values(065, 'Mao Zhe Bong', 'newPresident@gmail.com', '1920/09/26', 'M', 027)
Insert into Passenger values(066, 'Jiang Ling', 'presidentWife@gmail.com', '1914/03/19', 'F', 027)

Insert into Passenger values(067, 'Tok Tik Xi', 'sociallifeonly@yahoo.com', '2016/09/18', 'F', 028)
Insert into Passenger values(068, 'MeTube Lee', 'entertainingme@gmail.com', '2005/02/14', 'M', 028)
Insert into Passenger values(069, 'Steve Jobless', 'unemployedsad@gmail.com', '1990/06/19', 'M', 028)
Insert into Passenger values(070, 'Linda Job', 'getdatbread@gmail.com', '1985/07/18', 'F', 028)

Insert into Passenger values(071, 'Lee Wee Kang', 'imgoingonacruise!@gmail.com', '2004/10/01', 'M', 029)
Insert into Passenger values(072, 'Lee Brother', 'businessonly@gmail.com', '1999/05/05', 'M', 029)
Insert into Passenger values(073, 'Lee Sister', 'fashionista@gmail.com', '2002/08/21', 'F', 029)
Insert into Passenger values(074, 'Lee Mother', 'womenti@yahoo.com', '1974/11/17', 'F', 029)
Insert into Passenger values(075, 'Lee Father', 'family4life@gmail.com', '1972/09/13', 'M', 029)

Insert into Passenger values(076, 'Mr Bean', 'greencar@gmail.com', '1955/01/06', 'M', 030)
Insert into Passenger values(077, 'Mrs Bean', 'bluecar@gmail.com', '1956/11/11', 'F', 030)
Insert into Passenger values(078, 'Breanie', null, '2019/06/21', 'F', 030)

Insert into Passenger values(079, 'Granny Eddie', 'catlover69@yahoo.com', '1970/02/22', 'F', 031)

Insert into Passenger values(080, 'Andrea Jay', 'friend1@yahoo.com', '1986/11/21', 'F', 032)
Insert into Passenger values(081, 'Poo Loo Poo', 'friend2@gmail.com', '1999/06/03', 'M', 032)
Insert into Passenger values(082, 'Robinson', 'thirdwheeler@yahoo.com', '1999/07/13', 'M', 032)
Insert into Passenger values(083, 'Andrew Reuben', 'bfmaterial@gmail.com', '1996/06/18', 'M', 032)
Insert into Passenger values(084, 'Rosamary Dickens', 'gfmaterial@gmail.com', '1998/12/14', 'F', 032)

Insert into Passenger values(085, 'Amos Yee', 'gotDeportedLOL@gmail.com', '1998/10/31', 'M', 033)

Insert into Passenger values(086, 'Chi Ren', 'eateateat@gmail.com', '2002/01/23', 'M', 034)
Insert into Passenger values(087, 'Ether', 'whatamidoinghere@gmail.com', '2001/10/16', 'F', 034)

Insert into Passenger values(088, 'Long Johns S', 'yummy@yahoo.com', '1975/10/10', 'F', 035)
Insert into Passenger values(089, 'Burger Queen', 'notacopyofronald@yahoo.com', '1965/08/09', 'F', 035)
Insert into Passenger values(090, 'Mac Ronald', 'imaclown@gmail.com', '1976/03/05', 'F', 035)
Insert into Passenger values(091, 'Kentucky Fish Chicken', 'fingerlickinggood@gmail.com', '1977/02/22', 'F', 035)

Insert into Passenger values(092, 'Nameless Bob', 'whoami@gmail.com', '1990/03/26', 'M', 036)

Insert into Passenger values(093, 'Wendigo Jill', 'scarymonster@gmail.com', '1962/02/15', 'F', 037)
Insert into Passenger values(094, 'Jelly Willy', 'jellywilly@gmail.com', '1963/03/08', 'M', 037)
Insert into Passenger values(095, 'Sui Xia', 'XiaSui@gmail.com', '1974/07/23', 'F', 037)
Insert into Passenger values(096, 'Chad Brad', 'chad@gmail.com', '1975/01/04', 'M', 037)

Insert into Passenger values(097, 'Angel Love', 'heartstrings@gmail.com', '1997/06/06', 'F', 038)
Insert into Passenger values(098, 'Mevil', 'dungeonsndragons@gmail.com', '1998/09/11', 'M', 038)

Insert into Passenger values(099, 'Fairy Li', 'fairy@gmail.com', '1977/11/21', 'F', 039)
Insert into Passenger values(100, 'Goblin Li', 'goblin@yahoo.com', '1978/01/12', 'M', 039)

Insert into Passenger values(101, 'Despo', 'desperate@gmail.com', '1988/01/11', 'M', 040)
Insert into Passenger values(102, 'Kid', null, '2007/01/12', 'M', 040)

Insert into Passenger values(103, 'Saerom', 'saerom@gmail.com', '1995/01/01', 'F', 041)
Insert into Passenger values(104, 'Seoyeon', null, '2008/01/22', 'F', 041)

Insert into Passenger values(105, 'Luffy', 'luffy@yahoo.com', '1999/05/05', 'M', 042)
Insert into Passenger values(106, 'Boa Hancock', 'hancock@gmail.com', '2000/08/09', 'F', 042)
Insert into Passenger values(107, 'Chopper', null, '2008/10/18', 'M', 042)

Insert into Passenger values(108, 'Nico Robin', 'Robin@gmail.com', '1985/05/06', 'F', 043)
Insert into Passenger values(109, 'Zoro', 'swords@yahoo.com', '1991/02/22', 'M', 043)
Insert into Passenger values(110, 'Eusatuss Kidd', null, '2009/12/05', 'M', 043)

Insert into Passenger values(111, 'Gyuri', 'gyuri@gmail.com', '1987/04/07', 'F', 044)
Insert into Passenger values(112, 'Baek Jiheon', null, '2008/07/14', 'F', 044)

Insert into Passenger values(113, 'Kirito', 'sao@yahoo.com', '1987/12/11', 'M', 045)
Insert into Passenger values(114, 'Asuna', 'alo@yahoo.com', '1989/03/05', 'F', 045)
Insert into Passenger values(115, 'Yui', null, '2009/01/30', 'F', 045)
Insert into Passenger values(116, 'Klien', null, '2009/01/30', 'M', 045)

Insert into Passenger values(117, 'Rosawall', 'mansion@gmail.com', '1985/01/14', 'M', 046)
Insert into Passenger values(118, 'Beatrice', null, '2009/05/19', 'F', 046)

Insert into Passenger values(119, 'Franky', 'cola@gmail.com', '1987/07/07', 'M', 047)
Insert into Passenger values(120, 'Petra', null, '2009/12/22', 'F', 047)
select * from passenger /* Total: 120 */

Insert into PgrContactNo values(1, '98745615')
Insert into PgrContactNo values(1, '84654123')
Insert into PgrContactNo values(2, '87456123')
Insert into PgrContactNo values(3, '98756812')
Insert into PgrContactNo values(6, '91234567')
Insert into PgrContactNo values(7, '87458945')
Insert into PgrContactNo values(8, '87999456')
Insert into PgrContactNo values(9, '98758774')
Insert into PgrContactNo values(10, '87984569')
Insert into PgrContactNo values(11, '98889456')
Insert into PgrContactNo values(14, '88899945')
Insert into PgrContactNo values(15, '88963254')
Insert into PgrContactNo values(15, '99654123')
Insert into PgrContactNo values(16, '65784512')
Insert into PgrContactNo values(17, '68745125')
Insert into PgrContactNo values(18, '87454114')
Insert into PgrContactNo values(19, '87774512')
Insert into PgrContactNo values(20, '65478899')
Insert into PgrContactNo values(22, '98663321')
Insert into PgrContactNo values(23, '87774121')
Insert into PgrContactNo values(24, '68451234')
Insert into PgrContactNo values(25, '91222456')
Insert into PgrContactNo values(26, '87774111')
Insert into PgrContactNo values(29, '65412125')
Insert into PgrContactNo values(31, '65411147')
Insert into PgrContactNo values(32, '87496634')
Insert into PgrContactNo values(35, '89848445')
Insert into PgrContactNo values(36, '65484411')
Insert into PgrContactNo values(38, '88885511')
Insert into PgrContactNo values(39, '96451258')
Insert into PgrContactNo values(40, '87711122')
Insert into PgrContactNo values(41, '89944112')
Insert into PgrContactNo values(42, '88133276')
Insert into PgrContactNo values(43, '87444433')
Insert into PgrContactNo values(45, '66633311')
Insert into PgrContactNo values(47, '98754511')
Insert into PgrContactNo values(47, '89994411')
Insert into PgrContactNo values(49, '98413547')
Insert into PgrContactNo values(49, '81111111')
Insert into PgrContactNo values(49, '69111111')
Insert into PgrContactNo values(53, '87451245')
Insert into PgrContactNo values(54, '87444711')
Insert into PgrContactNo values(55, '65444111')
Insert into PgrContactNo values(59, '83332211')
Insert into PgrContactNo values(60, '96321114')
Insert into PgrContactNo values(61, '61333647')
Insert into PgrContactNo values(62, '65123478')
Insert into PgrContactNo values(63, '87774413')
Insert into PgrContactNo values(65, '88889996')
Insert into PgrContactNo values(66, '99885511')
Insert into PgrContactNo values(67, '87774444')
Insert into PgrContactNo values(68, '63332254')
Insert into PgrContactNo values(69, '69115969')
Insert into PgrContactNo values(70, '98713258')
Insert into PgrContactNo values(74, '87777999')
Insert into PgrContactNo values(75, '87999635')
Insert into PgrContactNo values(76, '99911236')
Insert into PgrContactNo values(77, '66633554')
Insert into PgrContactNo values(80, '87999324')
Insert into PgrContactNo values(81, '65458885')
Insert into PgrContactNo values(82, '87989878')
Insert into PgrContactNo values(85, '98765455')
Insert into PgrContactNo values(86, '98788855')
Insert into PgrContactNo values(86, '87848877')
Insert into PgrContactNo values(88, '65454788')
Insert into PgrContactNo values(89, '88888777')
Insert into PgrContactNo values(90, '90909090')
Insert into PgrContactNo values(91, '91919191')
Insert into PgrContactNo values(92, '92929233')
Insert into PgrContactNo values(93, '99393939')
Insert into PgrContactNo values(93, '83838389')
Insert into PgrContactNo values(94, '94874444')
Insert into PgrContactNo values(96, '65999333')
Insert into PgrContactNo values(97, '97979878')
Insert into PgrContactNo values(98, '98235777')
Insert into PgrContactNo values(99, '99999991')
Insert into PgrContactNo values(100, '91234657')
Insert into PgrContactNo values(101, '87987444')
Insert into PgrContactNo values(102, '87877774')
Insert into PgrContactNo values(103, '88877711')
Insert into PgrContactNo values(105, '98988877')
Insert into PgrContactNo values(106, '65444456')
Insert into PgrContactNo values(108, '81235444')
Insert into PgrContactNo values(111, '65444223')
Insert into PgrContactNo values(112, '84111000')
Insert into PgrContactNo values(113, '60012233')
Insert into PgrContactNo values(114, '90012354')
Insert into PgrContactNo values(117, '80014547')
Insert into PgrContactNo values(119, '65402117')
Insert into PgrContactNo values(120, '84651044')
select * from PgrContactNo /* Total 90 */


Insert into Eatery values(1, 'Steak House Wonderland', 'D11A', 20, '06:30:00', '23:00:00')
Insert into Eatery values(2, 'Fine Dining Club', 'D11C', 20, '06:15:00', '22:30:00') 
Insert into Eatery values(3, 'Zuccini', 'D11B', 15, '07:30:00', '22:30:00') 
Insert into Eatery values(4, 'Grill Chops', 'D11E', 30, '06:30:00', '23:00:00') 
Insert into Eatery values(5, 'Yummy Tummy', 'D11F', 25, '06:45:00', '22:30:00') 
Insert into Eatery values(6, 'Fish Galor!', 'D5B', 15, '07:30:00', '22:00:00') 
Insert into Eatery values(7, 'Gorden Ramsey', 'D5C', 15, '07:30:00', '23:00:00') 
Insert into Eatery values(8, 'Italian Mobster', 'D5D', 15, '06:45:00', '23:00:00') 
Insert into Eatery values(9, 'CAFÉ Lemonade', 'D5E', 10, '06:30:00', '21:30:00') 
Insert into Eatery values(10, 'LÉ Crossiant', 'D5A', 15, '06:15:00', '21:00:00') 
Insert into Eatery values(11, 'Windbreaker', 'D5F', 20, '07:45:00', '22:00:00') 
Insert into Eatery values(12, 'EatTilURFull', 'D12A', 30, '07:15:00', '22:30:00') 
Insert into Eatery values(13, 'La La Land', 'D12B', 10, '07:30:00', '23:00:00') 
Insert into Eatery values(14, 'Cooking Machine', 'D12C', 15, '06:30:00', '23:00:00') 
Insert into Eatery values(15, 'Quick Food', 'D12D', 30, '00:00:00', '23:59:59')
select * from Eatery /* Total: 15 */

Insert into Cuisine values(1, 'Chinese Cuisine')
Insert into Cuisine values(2, 'Japanese Cuisine')
Insert into Cuisine values(3, 'French Cuisine')	
Insert into Cuisine values(4, 'Indian Cuisine')
Insert into Cuisine values(5, 'Malay Cuisine')
Insert into Cuisine values(6, 'Italian Cuisine')
Insert into Cuisine values(7, 'Greek Cuisine')
Insert into Cuisine values(8, 'Spanish Cuisine')	
Insert into Cuisine values(9, 'Thai Cuisine')
Insert into Cuisine values(10, 'Turkish Cuisine')
Insert into Cuisine values(11, 'Korean Cuisine')
Insert into Cuisine values(12, 'Continental Cuisine')
select * from Cuisine /* Total: 12 */

Insert into Ingredient values(1, 'Chicken')
Insert into Ingredient values(2, 'Beef')
Insert into Ingredient values(3, 'Turkey')
Insert into Ingredient values(4, 'Pork')
Insert into Ingredient values(5, 'Olive Oil')
Insert into Ingredient values(6, 'All purpose flour')
Insert into Ingredient values(7, 'Sugar')
Insert into Ingredient values(8, 'Salt')
Insert into Ingredient values(9, 'Eggs')
Insert into Ingredient values(10, 'Rice')
Insert into Ingredient values(11, 'Vegetable Oil')
Insert into Ingredient values(12, 'Butter')
Insert into Ingredient values(13, 'Unsalted Butter')
Insert into Ingredient values(14, 'Cheese')
Insert into Ingredient values(15, 'Garlic')
Insert into Ingredient values(16, 'Onion')
Insert into Ingredient values(17, 'Corn')
Insert into Ingredient values(18, 'Mushrooms')
Insert into Ingredient values(19, 'Shrimp')
Insert into Ingredient values(20, 'Fish')
Insert into Ingredient values(21, 'Lamb')
Insert into Ingredient values(22, 'Apple')
Insert into Ingredient values(23, 'Orange')
Insert into Ingredient values(24, 'Bacon')
Insert into Ingredient values(25, 'Whole Milk')
Insert into Ingredient values(26, 'Hot Sauce')
Insert into Ingredient values(27, 'Chili')
Insert into Ingredient values(28, 'Ketchup')
Insert into Ingredient values(29, 'Vinegar')
Insert into Ingredient values(30, 'Vanilla Extract')
Insert into Ingredient values(31, 'Pasta')
Insert into Ingredient values(32, 'Honey')
Insert into Ingredient values(33, 'Baking Soda')
Insert into Ingredient values(34, 'Baking Powder')
Insert into Ingredient values(35, 'Potatoes')
Insert into Ingredient values(36, 'Pepper')
Insert into Ingredient values(37, 'Vegetables')
Insert into Ingredient values(38, 'Bread')
Insert into Ingredient values(39, 'Ginger')
Insert into Ingredient values(40, 'Soy sauce')
Insert into Ingredient values(41, 'Nuts')
Insert into Ingredient values(42, 'Syrup')
select * from Ingredient /* Total: 42 */

Insert into FoodCategory values(1, 'Vegetarian', 'No meat ingredients, vegetables only')
Insert into FoodCategory values(2, 'Pescatarian', 'No meat ingredients except for fish, vegetables only')
Insert into FoodCategory values(3, 'Vegan', 'No meat and animal products') 
Insert into FoodCategory values(4, 'Halal', 'No pork, reptiles, amphibians and insects')
Insert into FoodCategory values(5, 'Kosher', 'No pork, rabbits, predator birds or cuts of beef from hindquater of the animal')
Insert into FoodCategory values(6, 'International', 'Food that can be eaten by everyone with no restrictions')
Insert into FoodCategory values(7, 'Pasta', 'Spaghetti, macaroni, noodles, etc.')
Insert into FoodCategory values(8, 'Desserts', 'Ice-cream, pudding, fresh or cooked fruits, etc.')
Insert into FoodCategory values(9, 'Salad', 'A mixture of raw green, vegetables and toppings served with dressing')
Insert into FoodCategory values(10, 'Snacks', 'A small portion of food eaten between meals')
Insert into FoodCategory values(11, 'Stew', 'Small, uniform pieces of meat that are totally immersed in liquid and slowly simmered')
Insert into FoodCategory values(12, 'Soup', 'Liquid or thick, creamy food that is served hot')
Insert into FoodCategory values(13, 'Meatarian', 'Has only meat ingredients')
select * from foodcategory /* Total: 13 */

Insert into Reservation values(1, 'B', '2022/01/20 08:15:00', '2022/01/20 11:30:00', 4, 002, 13)
Insert into Reservation values(2, 'B', '2022/01/20 08:20:00', '2022/01/20 11:40:00', 2, 006, 2)
Insert into Reservation values(3, 'P', '2022/01/20 08:25:00', '2022/01/20 11:40:00', 3, 010, 4)
Insert into Reservation values(4, 'C', '2022/01/20 08:30:00', '2022/01/20 12:45:00', 3, 013, 11)
Insert into Reservation values(5, 'C', '2022/01/20 08:30:00', '2022/01/20 11:30:00', 1, 014, 12)
Insert into Reservation values(6, 'P', '2022/01/20 08:35:00', '2022/01/20 10:35:00', 1, 015, 2)
Insert into Reservation values(7, 'P', '2022/01/20 08:40:00', '2022/01/20 12:30:00', 2, 016, 1)
Insert into Reservation values(8, 'B', '2022/01/20 08:45:00', '2022/01/20 11:40:00', 1, 018, 2)
Insert into Reservation values(9, 'P', '2022/01/20 08:50:00', '2022/01/20 10:20:00', 4, 020, 10)
Insert into Reservation values(10, 'B', '2022/01/20 08:55:00', '2022/01/20 11:20:00', 2, 023, 15)
Insert into Reservation values(11, 'B', '2022/01/20 09:10:00', '2022/01/20 10:30:00', 1, 025, 13)
Insert into Reservation values(12, 'C', '2022/01/20 09:20:00', '2022/01/20 11:00:00', 3, 027, 3)
Insert into Reservation values(13, 'p', '2022/01/20 09:25:00', '2022/01/20 12:25:00', 2, 029, 2)
Insert into Reservation values(14, 'C', '2022/01/20 09:25:00', '2022/01/20 12:30:00', 5, 034, 14)
Insert into Reservation values(15, 'P', '2022/01/20 09:30:00', '2022/01/20 11:00:00', 2, 036, 8)
Insert into Reservation values(16, 'P', '2022/01/20 09:30:00', '2022/01/20 12:30:00', 1, 038, 9)
Insert into Reservation values(17, 'C', '2022/01/20 09:35:00', '2022/01/20 11:30:00', 1, 039, 7)
Insert into Reservation values(18, 'B', '2022/01/20 09:35:00', '2022/01/20 11:55:00', 1, 040, 5)
Insert into Reservation values(19, 'B', '2022/01/20 09:40:00', '2022/01/20 11:50:00', 3, 041, 4)
Insert into Reservation values(20, 'C', '2022/01/20 09:45:00', '2022/01/20 11:30:00', 2, 045, 8)
Insert into Reservation values(21, 'P', '2022/01/20 09:45:00', '2022/01/20 12:35:00', 3, 047, 2)
Insert into Reservation values(22, 'B', '2022/01/20 09:50:00', '2022/01/20 12:30:00', 4, 050, 14)
Insert into Reservation values(23, 'B', '2022/01/20 09:50:00', '2022/01/20 11:30:00', 2, 053, 1)
Insert into Reservation values(24, 'B', '2022/01/20 09:55:00', '2022/01/20 12:15:00', 2, 055, 9)
Insert into Reservation values(25, 'P', '2022/01/20 09:55:00', '2022/01/20 12:30:00', 5, 060, 7)

Insert into Reservation values(26, 'B', '2022/01/20 08:15:00', '2022/01/20 21:30:00', 4, 002, 6)
Insert into Reservation values(27, 'P', '2022/01/20 08:20:00', '2022/01/20 21:40:00', 2, 006, 8)
Insert into Reservation values(28, 'P', '2022/01/20 08:25:00', '2022/01/20 21:40:00', 3, 010, 5)
Insert into Reservation values(29, 'B', '2022/01/20 08:30:00', '2022/01/20 20:00:00', 3, 013, 6)
Insert into Reservation values(30, 'B', '2022/01/20 08:30:00', '2022/01/20 21:30:00', 1, 014, 9)
Insert into Reservation values(31, 'C', '2022/01/20 08:35:00', '2022/01/20 20:35:00', 1, 015, 7)
Insert into Reservation values(32, 'P', '2022/01/20 08:40:00', '2022/01/20 20:30:00', 2, 016, 6)
Insert into Reservation values(33, 'B', '2022/01/20 08:45:00', '2022/01/20 21:40:00', 1, 018, 5)
Insert into Reservation values(34, 'C', '2022/01/20 08:50:00', '2022/01/20 20:20:00', 4, 020, 10)
Insert into Reservation values(35, 'B', '2022/01/20 08:55:00', '2022/01/20 21:20:00', 2, 023, 13)
Insert into Reservation values(36, 'C', '2022/01/20 09:10:00', '2022/01/20 20:30:00', 1, 025, 15)
Insert into Reservation values(37, 'B', '2022/01/20 09:20:00', '2022/01/20 21:00:00', 3, 027, 3)
Insert into Reservation values(38, 'P', '2022/01/20 09:25:00', '2022/01/20 20:25:00', 2, 029, 10)
Insert into Reservation values(39, 'C', '2022/01/20 09:25:00', '2022/01/20 20:30:00', 5, 034, 13)
Insert into Reservation values(40, 'B', '2022/01/20 09:30:00', '2022/01/20 21:00:00', 2, 036, 15)
Insert into Reservation values(41, 'P', '2022/01/20 09:30:00', '2022/01/20 20:30:00', 1, 038, 13)
Insert into Reservation values(42, 'C', '2022/01/20 09:35:00', '2022/01/20 21:30:00', 1, 039, 11)
Insert into Reservation values(43, 'P', '2022/01/20 09:35:00', '2022/01/20 21:55:00', 1, 040, 4)
Insert into Reservation values(44, 'C', '2022/01/20 09:40:00', '2022/01/20 21:50:00', 3, 041, 7)
Insert into Reservation values(45, 'P', '2022/01/20 09:45:00', '2022/01/20 21:30:00', 2, 045, 1)
Insert into Reservation values(46, 'B', '2022/01/20 09:45:00', '2022/01/20 20:35:00', 3, 047, 5)
Insert into Reservation values(47, 'C', '2022/01/20 09:50:00', '2022/01/20 20:30:00', 4, 050, 15)
Insert into Reservation values(48, 'C', '2022/01/20 09:50:00', '2022/01/20 21:30:00', 2, 053, 12)
Insert into Reservation values(49, 'C', '2022/01/20 09:55:00', '2022/01/20 20:15:00', 2, 055, 4)
Insert into Reservation values(50, 'P', '2022/01/20 09:55:00', '2022/01/20 20:30:00', 5, 060, 2)

Insert into Reservation values(51, 'P', '2022/01/20 08:15:00', '2022/01/21 08:30:00', 4, 002, 6)
Insert into Reservation values(52, 'C', '2022/01/20 08:20:00', '2022/01/21 09:40:00', 2, 006, 3)
Insert into Reservation values(53, 'C', '2022/01/20 08:25:00', '2022/01/21 09:40:00', 3, 010, 7)
Insert into Reservation values(54, 'B', '2022/01/20 08:30:00', '2022/01/21 08:45:00', 3, 013, 15)
Insert into Reservation values(55, 'C', '2022/01/20 08:30:00', '2022/01/21 09:30:00', 1, 014, 11)
Insert into Reservation values(56, 'P', '2022/01/20 08:35:00', '2022/01/21 08:35:00', 1, 015, 12)
Insert into Reservation values(57, 'P', '2022/01/20 08:40:00', '2022/01/21 09:30:00', 2, 016, 7)
Insert into Reservation values(58, 'B', '2022/01/20 08:45:00', '2022/01/21 08:40:00', 1, 018, 12)
Insert into Reservation values(59, 'B', '2022/01/20 08:50:00', '2022/01/21 09:20:00', 4, 020, 5)
Insert into Reservation values(60, 'B', '2022/01/20 08:55:00', '2022/01/21 09:20:00', 2, 023, 1)
Insert into Reservation values(61, 'B', '2022/01/20 09:10:00', '2022/01/21 08:30:00', 1, 025, 5)
Insert into Reservation values(62, 'P', '2022/01/20 09:20:00', '2022/01/21 08:00:00', 3, 027, 2)
Insert into Reservation values(63, 'B', '2022/01/20 09:25:00', '2022/01/21 09:25:00', 2, 029, 8)
Insert into Reservation values(64, 'C', '2022/01/20 09:25:00', '2022/01/21 09:30:00', 5, 034, 9)
Insert into Reservation values(65, 'C', '2022/01/20 09:30:00', '2022/01/21 08:00:00', 2, 036, 3)
Insert into Reservation values(66, 'C', '2022/01/20 09:30:00', '2022/01/21 09:30:00', 1, 038, 5)
Insert into Reservation values(67, 'C', '2022/01/20 09:35:00', '2022/01/21 08:30:00', 1, 039, 14)
Insert into Reservation values(68, 'B', '2022/01/20 09:35:00', '2022/01/21 09:55:00', 1, 040, 15)
Insert into Reservation values(69, 'P', '2022/01/20 09:40:00', '2022/01/21 08:50:00', 3, 041, 11)
Insert into Reservation values(70, 'C', '2022/01/20 09:45:00', '2022/01/21 09:30:00', 2, 045, 1)
Insert into Reservation values(71, 'P', '2022/01/20 09:45:00', '2022/01/21 09:35:00', 3, 047, 6)
Insert into Reservation values(72, 'C', '2022/01/20 09:50:00', '2022/01/21 08:30:00', 4, 050, 11)
Insert into Reservation values(73, 'B', '2022/01/20 09:50:00', '2022/01/21 09:30:00', 2, 053, 1)
Insert into Reservation values(74, 'P', '2022/01/20 09:55:00', '2022/01/21 08:15:00', 2, 055, 2)
Insert into Reservation values(75, 'C', '2022/01/20 09:55:00', '2022/01/21 09:30:00', 5, 060, 9)

Insert into Reservation values(76, 'P', '2022/01/21 08:15:00', '2022/01/21 11:30:00', 4, 002, 4)
Insert into Reservation values(77, 'B', '2022/01/21 08:20:00', '2022/01/21 11:40:00', 2, 006, 1)
Insert into Reservation values(78, 'P', '2022/01/21 08:25:00', '2022/01/21 11:40:00', 3, 010, 10)
Insert into Reservation values(79, 'C', '2022/01/21 08:30:00', '2022/01/21 12:45:00', 3, 013, 6)
Insert into Reservation values(80, 'C', '2022/01/21 08:30:00', '2022/01/21 11:30:00', 1, 014, 15)
Insert into Reservation values(81, 'B', '2022/01/21 08:35:00', '2022/01/21 10:35:00', 1, 015, 7)
Insert into Reservation values(82, 'P', '2022/01/21 08:40:00', '2022/01/21 12:30:00', 2, 016, 13)
Insert into Reservation values(83, 'B', '2022/01/21 08:45:00', '2022/01/21 11:40:00', 1, 018, 9)
Insert into Reservation values(84, 'P', '2022/01/21 08:50:00', '2022/01/21 10:20:00', 4, 020, 2)
Insert into Reservation values(85, 'C', '2022/01/21 08:55:00', '2022/01/21 11:20:00', 2, 023, 10)
Insert into Reservation values(86, 'B', '2022/01/21 09:10:00', '2022/01/21 10:30:00', 1, 025, 5)
Insert into Reservation values(87, 'C', '2022/01/21 09:20:00', '2022/01/21 11:00:00', 3, 027, 12)
Insert into Reservation values(88, 'P', '2022/01/21 09:25:00', '2022/01/21 12:25:00', 2, 029, 10)
Insert into Reservation values(89, 'C', '2022/01/21 09:25:00', '2022/01/21 12:30:00', 5, 034, 11)
Insert into Reservation values(90, 'C', '2022/01/21 09:30:00', '2022/01/21 11:00:00', 2, 036, 6)
Insert into Reservation values(91, 'P', '2022/01/21 09:30:00', '2022/01/21 12:30:00', 1, 038, 5)
Insert into Reservation values(92, 'B', '2022/01/21 09:35:00', '2022/01/21 11:30:00', 1, 039, 2)
Insert into Reservation values(93, 'C', '2022/01/21 09:35:00', '2022/01/21 11:55:00', 1, 040, 7)
Insert into Reservation values(94, 'P', '2022/01/21 09:40:00', '2022/01/21 11:50:00', 3, 041, 13)
Insert into Reservation values(95, 'C', '2022/01/21 09:45:00', '2022/01/21 11:30:00', 2, 045, 6)
Insert into Reservation values(96, 'C', '2022/01/21 09:45:00', '2022/01/21 12:35:00', 3, 047, 8)
Insert into Reservation values(97, 'P', '2022/01/21 09:50:00', '2022/01/21 12:30:00', 4, 050, 2)
Insert into Reservation values(98, 'B', '2022/01/21 09:50:00', '2022/01/21 11:30:00', 2, 053, 2)
Insert into Reservation values(99, 'C', '2022/01/21 09:55:00', '2022/01/21 12:15:00', 2, 055, 14)
Insert into Reservation values(100, 'B', '2022/01/21 09:55:00', '2022/01/21 12:30:00', 5, 060, 1)

Insert into Reservation values(101, 'C', '2022/01/21 08:15:00', '2022/01/21 21:30:00', 4, 002, 2)
Insert into Reservation values(102, 'C', '2022/01/21 08:20:00', '2022/01/21 21:40:00', 2, 006, 6)
Insert into Reservation values(103, 'B', '2022/01/21 08:25:00', '2022/01/21 21:40:00', 3, 010, 15)
Insert into Reservation values(104, 'B', '2022/01/21 08:30:00', '2022/01/21 20:00:00', 3, 013, 11)
Insert into Reservation values(105, 'B', '2022/01/21 08:30:00', '2022/01/21 21:30:00', 1, 014, 6)
Insert into Reservation values(106, 'B', '2022/01/21 08:35:00', '2022/01/21 20:35:00', 1, 015, 10)
Insert into Reservation values(107, 'P', '2022/01/21 08:40:00', '2022/01/21 20:30:00', 2, 016, 2)
Insert into Reservation values(108, 'C', '2022/01/21 08:45:00', '2022/01/21 21:40:00', 1, 018, 1)
Insert into Reservation values(109, 'C', '2022/01/21 08:50:00', '2022/01/21 20:20:00', 4, 020, 8)
Insert into Reservation values(110, 'P', '2022/01/21 08:55:00', '2022/01/21 21:20:00', 2, 023, 10)
Insert into Reservation values(111, 'P', '2022/01/21 09:10:00', '2022/01/21 20:30:00', 1, 025, 9)
Insert into Reservation values(112, 'B', '2022/01/21 09:20:00', '2022/01/21 21:00:00', 3, 027, 6)
Insert into Reservation values(113, 'C', '2022/01/21 09:25:00', '2022/01/21 20:25:00', 2, 029, 9)
Insert into Reservation values(114, 'P', '2022/01/21 09:25:00', '2022/01/21 20:30:00', 5, 034, 15)
Insert into Reservation values(115, 'P', '2022/01/21 09:30:00', '2022/01/21 21:00:00', 2, 036, 14)
Insert into Reservation values(116, 'B', '2022/01/21 09:30:00', '2022/01/21 20:30:00', 1, 038, 3)
Insert into Reservation values(117, 'B', '2022/01/21 09:35:00', '2022/01/21 21:30:00', 1, 039, 8)
Insert into Reservation values(118, 'C', '2022/01/21 09:35:00', '2022/01/21 21:55:00', 1, 040, 2)
Insert into Reservation values(119, 'C', '2022/01/21 09:40:00', '2022/01/21 21:50:00', 3, 041, 10)
Insert into Reservation values(120, 'C', '2022/01/21 09:45:00', '2022/01/21 21:30:00', 2, 045, 11)
Insert into Reservation values(121, 'P', '2022/01/21 09:45:00', '2022/01/21 20:35:00', 3, 047, 7)
Insert into Reservation values(122, 'C', '2022/01/21 09:50:00', '2022/01/21 20:30:00', 4, 050, 12)
Insert into Reservation values(123, 'B', '2022/01/21 09:50:00', '2022/01/21 21:30:00', 2, 053, 10)
Insert into Reservation values(124, 'P', '2022/01/21 09:55:00', '2022/01/21 20:15:00', 2, 055, 5)
Insert into Reservation values(125, 'C', '2022/01/21 09:55:00', '2022/01/21 20:30:00', 5, 060, 7)
select * from Reservation /* Total: 125 */

Insert into EventType values(1, 'Movie')
Insert into EventType values(2, 'Class')
Insert into EventType values(3, 'Play')
Insert into EventType values(4, 'Musical')
Insert into EventType values(5, 'Competition')
Insert into EventType values(6, 'High-Elements')
Insert into EventType values(7, 'Sports')
Insert into EventType values(8, 'Water Sports')
Insert into EventType values(9, 'Driving')
Insert into EventType values(10, 'Live Bands')
Insert into EventType values(11, 'Game Shows')
Insert into EventType values(12, 'Art Auctions')
select * from eventtype /* Total: 12 */

Insert into Event values(1, 'Drawing Class', 'Teaches you how to draw a live potrait.', 'Room 101, Deck 7', 40, 2, null, '10.00', 5, null, 2)
Insert into Event values(2, 'Bubble Tea Making Class', 'Teaches you how to make bubble tea.', 'Room 102, Deck 7', 30, 2, '10.00', '10.00', 6, null, 2)
Insert into Event values(3, 'Rock Climbing', 'Activity where participants climb up artificial rock walls.', 'Rock Climbing Wall, Deck 13', 60, 1.5, '15.00', '20.00', 9, null, 6)
Insert into Event values(4, 'Surf Simulators', 'A simulator that mimics what it is like to surf on the ocean.', 'Surfing Station, Deck 13', 50, 0.75, '15.00', '20.00', 9, null, 8)
Insert into Event values(5, 'Flying Fox', 'An activity where paricipants are allowed to free fall a distance of about 100 metres.', 'Rock Climbing Wall, Deck 13', 50, 0.75, '20.00', '25.00', 9, null, 6)
Insert into Event values(6, 'Water Rides and Slides', 'Participants can use the rides and slides at the swimming pool freely.', 'Swimming Pool, Deck 13', 50, 3, '10.00', '15.00', 9, null, 8)
Insert into Event values(7, 'Car Racing', 'Participants get to race around a track of 500 metres 3 times.', 'Racing track, Deck 13', 35, 1, '20.00', '30.00', 9, null, 9)
Insert into Event values(8, 'Skydiving Simulators', 'Participants get to experience how it is like to skydive.', 'Rock Climbing Wall, Deck 13', 30, 1, '30.00', '30.00', 9, null, 7)
Insert into Event values(9, 'Yoga', 'Yoga is a type of exercise in which you move your body in various positions in order to relax your mind.', 'Gym, Deck 12', 30, 1.5, null, null, null, null, 7)
Insert into Event values(10, 'Frozen', 'A movie that shows a princess who sets off on a journey alongside an iceman, his reindeer, and a snowman to find her enstranged sister.', 'Cinema 1, Deck 5', 40, 1.7, null, null, null, null, 1)
Insert into Event values(11, 'Titanic', 'A dramatic story of the Titanic with Leonardo Di Caprio and Kate Winslet as the main actors.', 'Cinema 2, Deck 5', 40, 3.25, null, null, 13, null, 1)
Insert into Event values(12, 'Mamma Mia!', 'The sunny funny tale inspired by the music of ABBA. On the eve of her wedding, a daughter’s quest to discover the identity of her father brings back 3 men from her mother’s past.', 'Theatre 1, Deck 5', 40, 2.75, null, null, 13, null, 4)
Insert into Event values(13, 'Aladdin', 'Aladdin is a gorgeously produced show that’s a delight from start to finish. The beloved characters from Disney’s 1992 animated hit are given fresh life on the Theatre stage.', 'Theatre 2, Deck 5', 40, 2.5, null, null, null, null, 4)
Insert into Event values(14, 'The Lion King', 'A lively stage adaptation of the Academy Award-winning 1994 Disney film, The Lion King is the story of a young lion prince living in the flourishing African Pride Lands.', 'Theatre 1, Deck 5', 40, 2.5, null, null, 6, null, 4)
Insert into Event values(15, 'The Phantom of the Opera', 'Both romantic and scary, The Phantom of the Opera is a thrilling night of theater with grand emotions. ', 'Theatre 2, Deck 5', 40, 2.5, null, null, 4, null, 4)
Insert into Event values(16, 'Hamlet', 'Hamlet is written by William Shakespeare. Hamlet is a play where it shows Hamlet madness, contemplation with life and death, and him seeking revenge in his uncle.', 'Theatre 1, Deck 5', 40, 2.75, null, null, 13, null, 3)
Insert into Event values(17, 'Death of Salesman', 'Death of Salesman is written by Arthur Miller. It addresses loss of identity and a man''s inability to accept change within himself and society.', 'Theatre 2, Deck 5', 40, 3, null, null, 13, null, 3)
Insert into Event values(18, 'Burger-Eating Competition', 'Most number of burger eaten by one person in 30 minutes receives a grand prize!', 'Room 103, Deck 8' , 15, 2, null, null, null, null, 5) 
Insert into Event values(19, '2vs2 Basketball Competition', '2 versus 2 basketball competition where the winners would get a huge reward.', 'Basketball court, Deck 13', 20, 3, null, null, 13, null, 5)
Insert into Event values(20, 'Bingo!', 'The winner for Bingo! would get a nice sum of $888.', 'Room 104, Deck 8', 30, 3, null, null, null, null, 5)
Insert into Event values(21, 'DAY6', 'DAY6 is a South Korean rock band under JYP Entertainment.', 'Bar, Deck 4', 40, 2, null, null, null, null, 10) 
Insert into Event values(22, 'Maroon5', 'Maroon 5 is an American pop rock band, most famous for its song, ''payphone''', 'Bar, Deck, 4', 40, 2, null, null, null, null, 10)
Insert into Event values(23, 'Wheel of Fortune', 'A popular game show where participants get to solve word puzzles in order to win cash prizes', 'Room 105, Deck 9', 5, 2, null, null, 21, null, 11)
Insert into Event values(24, 'Jeopardy!', 'A popular game show where the host tests the knowledge of the contestants on a wide range of subjects and the winner gets a hefty sum of $888.', 'Room 106, Deck 9', 10, 4, null, null, 18, null, 11)
Insert into Event values(25, 'Art Auction', 'An art auctin where the highest bidder gets to buy the art he wants.', 'Room 107, Deck 10', 20, 3, null, null, 21, null, 12)
select * from event /* Total: 25 */
select eventid, eventname, eventloc, eventduration, minage from event

/* Insert EventSession */
Insert into EventSession values(1, '2022/01/20 13:00:00', 1)
Insert into EventSession values(2, '2022/01/21 16:00:00', 1)

Insert into EventSession values(1, '2022/01/20 16:00:00', 2)
Insert into EventSession values(2, '2022/01/21 10:00:00', 2)

Insert into EventSession values(1, '2022/01/20 13:00:00', 3)
Insert into EventSession values(2, '2022/01/20 16:00:00', 3)
Insert into EventSession values(3, '2022/01/21 09:00:00', 3)
Insert into EventSession values(4, '2022/01/21 13:00:00', 3)
Insert into EventSession values(5, '2022/01/22 09:00:00', 3)

Insert into EventSession values(1, '2022/01/20 13:30:00', 4)
Insert into EventSession values(2, '2022/01/20 19:00:00', 4)
Insert into EventSession values(3, '2022/01/21 09:30:00', 4)
Insert into EventSession values(4, '2022/01/21 14:00:00', 4)

Insert into EventSession values(1, '2022/01/20 14:30:00', 5)
Insert into EventSession values(2, '2022/01/21 09:30:00', 5)
Insert into EventSession values(3, '2022/01/21 14:30:00', 5)
Insert into EventSession values(4, '2022/01/22 09:00:00', 5)

Insert into EventSession values(1, '2022/01/20 15:00:00', 6)
Insert into EventSession values(2, '2022/01/20 18:00:00', 6)
Insert into EventSession values(3, '2022/01/21 09:00:00', 6)
Insert into EventSession values(4, '2022/01/21 14:00:00', 6)
Insert into EventSession values(5, '2022/01/21 18:00:00', 6)

Insert into EventSession values(1, '2022/01/20 12:00:00', 7)
Insert into EventSession values(2, '2022/01/20 16:00:00', 7)
Insert into EventSession values(3, '2022/01/21 10:00:00', 7)
Insert into EventSession values(4, '2022/01/21 16:00:00', 7)
Insert into EventSession values(5, '2022/01/21 09:00:00', 7)

Insert into EventSession values(1, '2022/01/20 15:00:00', 8)
Insert into EventSession values(2, '2022/01/20 18:00:00', 8)
Insert into EventSession values(3, '2022/01/21 09:30:00', 8)
Insert into EventSession values(4, '2022/01/21 15:00:00', 8)
Insert into EventSession values(5, '2022/01/22 09:00:00', 8)

Insert into EventSession values(1, '2022/01/20 14:00:00', 9)
Insert into EventSession values(2, '2022/01/20 20:00:00', 9)
Insert into EventSession values(3, '2022/01/21 08:30:00', 9)
Insert into EventSession values(4, '2022/01/21 14:00:00', 9)
Insert into EventSession values(5, '2022/01/21 20:00:00', 9)
Insert into EventSession values(6, '2022/01/22 08:00:00', 9)

Insert into EventSession values(1, '2022/01/20 11:30:00', 10)
Insert into EventSession values(2, '2022/01/20 15:00:00', 10)
Insert into EventSession values(3, '2022/01/20 20:00:00', 10)
Insert into EventSession values(4, '2022/01/21 11:00:00', 10)
Insert into EventSession values(5, '2022/01/21 20:00:00', 10)

Insert into EventSession values(1, '2022/01/20 12:45:00', 11)
Insert into EventSession values(2, '2022/01/20 21:00:00', 11)
Insert into EventSession values(3, '2022/01/21 10:00:00', 11)
Insert into EventSession values(4, '2022/01/21 16:30:00', 11)
Insert into EventSession values(5, '2022/01/21 20:45:00', 11)

Insert into EventSession values(1, '2022/01/20 14:45:00', 12)

Insert into EventSession values(1, '2022/01/20 18:00:00', 13)
Insert into EventSession values(2, '2022/01/21 13:00:00', 13)

Insert into EventSession values(1, '2022/01/20 13:30:00', 14)
Insert into EventSession values(2, '2022/01/20 19:00:00', 14)

Insert into EventSession values(1, '2022/01/21 12:45:00', 15)
Insert into EventSession values(2, '2022/01/21 20:00:00', 15)

Insert into EventSession values(1, '2022/01/20 21:00:00', 16)

Insert into EventSession values(1, '2022/01/21 21:00:00', 17)

Insert into EventSession values(1, '2022/01/20 11:45:00', 18)

Insert into EventSession values(1, '2022/01/21 16:00:00', 19)

Insert into EventSession values(1, '2022/01/20 20:30:00', 20)

Insert into EventSession values(1, '2022/01/20 20:00:00', 21)

Insert into EventSession values(1, '2022/01/21 20:00:00', 22)

Insert into EventSession values(1, '2022/01/20 14:45:00', 23)

Insert into EventSession values(1, '2022/01/21 19:45:00', 24)

Insert into EventSession values(1, '2022/01/21 21:00:00', 25)
select * from eventsession /* Total: 65 */

/* Inser Boooking */
Insert into Booking values(1, 'B', '2022/01/20 08:30:00', 1, 1, null, 10.00, 002, 1, 1)
Insert into Booking values(2, 'B', '2022/01/20 08:30:10', 0, 2, null, 40.0, 006, 4, 2)
Insert into Booking values(3, 'C', '2022/01/20 08:30:20', 0, 3, null, null, 008, 11, 2)
Insert into Booking values(4, 'P', '2022/01/20 08:32:00', 1, 2, 30.0, 60.0, 013, 8, 1)
Insert into Booking values(5, 'C', '2022/01/20 08:33:00', 0, 1, null, null, 014, 14, 1)
Insert into Booking values(6, 'B', '2022/01/20 08:33:00', 0, 1, null, null, 002, 21, 1)
Insert into Booking values(7, 'P', '2022/01/20 08:35:00', 0, 2, null, 40.0, 016, 3, 2)
Insert into Booking values(8, 'C', '2022/01/20 08:36:00', 0, 1, null, null, 018, 16, 1)
Insert into Booking values(9, 'B', '2022/01/20 08:37:00', 0, 4, null, 120.0, 019, 7, 2)
Insert into Booking values(10, 'B', '2022/01/20 08:40:00', 0, 2, null, 40.0, 023, 4, 1)
Insert into Booking values(11, 'B', '2022/01/20 08:44:00', 0, 1, null, null, 025, 14, 1)
Insert into Booking values(12, 'B', '2022/01/20 08:45:01', 0, 2, null, 20.00, 026, 1, 1)
Insert into Booking values(13, 'P', '2022/01/20 09:00:00', 0, 2, null, 20.00, 030, 2, 1)
Insert into Booking values(14, 'C', '2022/01/20 09:05:00', 0, 1, null, 20.00, 031, 3, 1)
Insert into Booking values(15, 'C', '2022/01/20 09:10:00', 0, 3, null, 60.00, 033, 3, 1)
Insert into Booking values(16, 'P', '2022/01/20 09:11:00', 1, 1, 15.00, 20.00, 001, 3, 2)
Insert into Booking values(17, 'B', '2022/01/20 09:20:00', 0, 1, null, 20.00, 041, 4, 1)
Insert into Booking values(18, 'B', '2022/01/20 09:20:00', 0, 2, null, 40.00, 042, 4, 1)
Insert into Booking values(19, 'B', '2022/01/20 09:25:00', 0, 3, null, 75.00, 047, 5, 1)
Insert into Booking values(20, 'B', '2022/01/20 09:45:00', 0, 2, null, 30.00, 049, 6, 1)
Insert into Booking values(21, 'B', '2022/01/20 09:55:00', 0, 2, null, 30.00, 051, 6, 2)
Insert into Booking values(22, 'P', '2022/01/20 10:01:00', 0, 2, null, 60.00, 053, 7, 1)
Insert into Booking values(23, 'B', '2022/01/20 10:02:00', 0, 2, null, null, 080, 18, 1)
Insert into Booking values(24, 'C', '2022/01/20 10:02:05', 0, 3, null, null, 083, 18, 1)
Insert into Booking values(25, 'B', '2022/01/20 10:05:00', 0, 2, null, null, 085, 23, 1)
Insert into Booking values(26, 'B', '2022/01/20 10:05:00', 0, 1, null, 30.00, 047, 7, 2)
Insert into Booking values(27, 'P', '2022/01/20 10:05:03', 0, 1, null, 30.00, 055, 8, 1)
Insert into Booking values(28, 'C', '2022/01/20 10:07:07', 0, 2, null, 60.00, 090, 7, 1)
Insert into Booking values(29, 'B', '2022/01/20 10:08:00', 0, 1, null, null, 058, 9, 1)
Insert into Booking values(30, 'B', '2022/01/20 10:15:15', 1, 2, 20.00, 50.00, 057, 7, 1)
Insert into Booking values(31, 'P', '2022/01/20 10:16:00', 0, 3, null, null, 059, 10, 1)
Insert into Booking values(32, 'P', '2022/01/20 10:17:01', 0, 3, null, 45.00, 095, 6, 2)
Insert into Booking values(33, 'B', '2022/01/20 10:19:19', 0, 1, null, null, 100, 8, 1)
Insert into Booking values(34, 'B', '2022/01/20 10:20:00', 0, 1, null, null, 062, 13, 1)
Insert into Booking values(35, 'C', '2022/01/20 10:30:00', 0, 2, null, null, 068, 14, 1)
Insert into Booking values(36, 'B', '2022/01/20 10:45:00', 0, 3, null, null, 075, 18, 1)
Insert into Booking values(37, 'C', '2022/01/20 10:50:00', 0, 2, null, null, 078, 23, 1)
Insert into Booking values(38, 'B', '2022/01/20 11:00:00', 0, 1, null, null, 072, 23, 1)
Insert into Booking values(39, 'B', '2022/01/20 11:11:11', 1, 1, 15.00, 30.00, 101, 2, 1)
Insert into Booking values(40, 'C', '2022/01/20 11:15:00', 1, 1, null, null, 101, 14, 2)
Insert into Booking values(41, 'B', '2022/01/20 11:15:01', 0, 2, null, null, 045, 18, 1)
Insert into Booking values(42, 'B', '2022/01/20 11:15:10', 1, 1, 30.00, 30.00, 103, 8, 2)
Insert into Booking values(43, 'P', '2022/01/20 11:20:00', 0, 2, null, 60.00, 106, 7, 2)
Insert into Booking values(44, 'P', '2022/01/20 11:21:01', 0, 1, null, null, 055, 18, 1)
Insert into Booking values(45, 'C', '2022/01/20 11:24:24', 0, 2, null, null, 097, 18, 1)
Insert into Booking values(46, 'C', '2022/01/20 11:25:00', 1, 0, 10.00, null, 107, 2, 1)
Insert into Booking values(47, 'B', '2022/01/20 11:45:00', 1, 1, 20.00, 25.00, 108, 5, 1)
Insert into Booking values(48, 'B', '2022/01/20 11:50:00', 0, 1, null, 15.00, 109, 6, 2)
Insert into Booking values(49, 'B', '2022/01/20 12:00:00', 1, 1, 10.00, 10.00, 111, 2, 1)
Insert into Booking values(50, 'B', '2022/01/20 12:30:00', 1, 1, null, null, 111, 14, 2)
Insert into Booking values(51, 'B', '2022/01/20 12:35:00', 1, 1, 20.00, 25.00, 113, 5, 1)
Insert into Booking values(52, 'B', '2022/01/20 12:30:00', 1, 1, 15.00, 20.00, 114, 3, 2)
Insert into Booking values(53, 'B', '2022/01/20 12:55:00', 1, 0, 30.00, null, 117, 7, 2)
Insert into Booking values(54, 'B', '2022/01/20 12:59:00', 0, 1, null, 30.00, 117, 8, 1)
Insert into Booking values(55, 'P', '2022/01/20 13:05:00', 1, 1, null, null, 118, 10, 2)
Insert into Booking values(56, 'P', '2022/01/20 13:20:00', 1, 1, null, null, 118, 14, 2)

Insert into Booking values(57, 'B', '2022/01/20 13:30:00', 1, 1, null, null, 001, 9, 3)
Insert into Booking values(58, 'B', '2022/01/20 13:35:05', 1, 2, 10.00, 30.00, 001, 6, 4)
Insert into Booking values(59, 'B', '2022/01/20 13:45:55', 1, 0, 20.00, null, 001, 5, 3)
Insert into Booking values(60, 'C', '2022/01/20 14:00:00', 0, 2, null, 40.00, 006, 3, 3)
Insert into Booking values(61, 'B', '2022/01/20 13:30:00', 0, 1, null, 15.00, 008, 6, 3)
Insert into Booking values(62, 'P', '2022/01/20 13:35:00', 0, 2, null, null, 009, 19, 1)
Insert into Booking values(63, 'C', '2022/01/20 13:55:00', 0, 2, null, 60.00, 009, 7, 5)
Insert into Booking values(64, 'B', '2022/01/20 14:30:00', 0, 2, null, null, 011, 19, 1)
Insert into Booking values(65, 'B', '2022/01/20 14:45:55', 1, 2, 30.00, 60.00, 011, 8, 3)
Insert into Booking values(66, 'B', '2022/01/20 15:00:00', 1, 2, null, null, 011, 11, 4)
Insert into Booking values(67, 'P', '2022/01/20 15:05:00', 0, 1, null, 20.00, 014, 4, 3)
Insert into Booking values(68, 'B', '2022/01/20 15:15:00', 0, 1, null, null, 014, 15, 2)
Insert into Booking values(69, 'B', '2022/01/20 15:15:15', 0, 1, null, 25.00, 015, 5, 2)
Insert into Booking values(70, 'B', '2022/01/20 15:30:00', 0, 1, null, null, 015, 5, 2)
Insert into Booking values(71, 'P', '2022/01/20 15:35:00', 0, 2, null, null, 017, 11, 3)
Insert into Booking values(72, 'B', '2022/01/20 15:35:01', 0, 1, null, null, 018, 11, 3)
Insert into Booking values(73, 'B', '2022/01/20 15:55:00', 0, 2, null, null, 017, 10, 5)
Insert into Booking values(74, 'B', '2022/01/20 15:55:01', 0, 1, null, null, 018, 10, 5)
Insert into Booking values(75, 'C', '2022/01/20 15:59:01', 0, 1, null, 10.00, 020, 2, 2)
Insert into Booking values(76, 'B', '2022/01/20 16:00:00', 0, 2, null, 60.00, 021, 7, 3)
Insert into Booking values(77, 'B', '2022/01/20 16:15:55', 1, 1, null, null, 023, 10, 4)
Insert into Booking values(78, 'B', '2022/01/20 16:20:13', 0, 2, null, null, 102, 20, 1)
Insert into Booking values(79, 'P', '2022/01/20 16:21:55', 0, 1, null, null, 100, 20, 1)
Insert into Booking values(80, 'B', '2022/01/20 16:24:24', 0, 3, null, null, 098, 20, 1)
Insert into Booking values(81, 'B', '2022/01/20 16:25:16', 1, 1, null, null, 023, 22, 1)
Insert into Booking values(82, 'B', '2022/01/20 16:25:35', 0, 1, null, null, 025, 15, 1)
Insert into Booking values(83, 'C', '2022/01/20 16:45:41', 0, 1, null, null, 025, 25, 1)
Insert into Booking values(84, 'B', '2022/01/20 17:00:08', 0, 3, null, 75.00, 026, 5, 2)
Insert into Booking values(85, 'B', '2022/01/20 17:11:11', 0, 3, null, null, 026, 25, 1)
Insert into Booking values(86, 'B', '2022/01/20 17:17:17', 0, 2, null, null, 027, 19, 1)
Insert into Booking values(87, 'P', '2022/01/20 18:00:00', 0, 1, null, 20.00, 031, 3, 4)
Insert into Booking values(88, 'B', '2022/01/20 18:05:04', 0, 2, null, null, 032, 13, 2)
Insert into Booking values(89, 'C', '2022/01/20 18:15:51', 0, 1, null, 20.00, 035, 4, 4)
Insert into Booking values(90, 'P', '2022/01/20 19:00:00', 0, 2, null, null, 036, 19, 1)
Insert into Booking values(91, 'C', '2022/01/20 19:25:02', 0, 2, null, 30.00, 036, 7, 3)
Insert into Booking values(92, 'C', '2022/01/20 19:43:41', 0, 1, null, null, 038, 24, 1)
Insert into Booking values(93, 'B', '2022/01/20 20:08:04', 0, 1, null, null, 037, 24, 1)
Insert into Booking values(94, 'B', '2022/01/20 20:16:41', 0, 1, null, null, 039, 24, 1)
Insert into Booking values(95, 'B', '2022/01/20 20:55:15', 0, 1 , null, 30.00, 039, 7, 3)
Insert into Booking values(96, 'P', '2022/01/20 20:59:45', 0, 1, null, null, 040, 24, 1)
Insert into Booking values(97, 'B', '2022/01/20 21:00:15', 0, 1 , null, 30.00, 040, 7, 3)
Insert into Booking values(98, 'B', '2022/01/20 21:11:15', 0, 2, null, null, 041, 19, 1)
Insert into Booking values(99, 'B', '2022/01/20 21:12:15', 0, 3, null, null, 042, 22, 1)
Insert into Booking values(100, 'B', '2022/01/20 21:15:15', 0, 2, null, null, 045, 19, 1)
Insert into Booking values(101, 'B', '2022/01/20 21:55:15', 0, 2, null, null, 046, 10, 4)
Insert into Booking values(102, 'B', '2022/01/20 21:59:15', 0, 2, null, null, 049, 15, 1)
Insert into Booking values(103, 'B', '2022/01/20 22:15:15', 0, 2, null, 40.00, 051, 3, 4)
Insert into Booking values(104, 'P', '2022/01/20 22:20:20', 0, 2, null, null, 053, 13, 2)
Insert into Booking values(105, 'B', '2022/01/20 22:21:00', 0, 2, null, 40.00, 055, 4, 4)
Insert into Booking values(106, 'P', '2022/01/20 21:11:15', 1, 2, 10.00, 30.00, 057, 6, 4)
Insert into Booking values(107, 'B', '2022/01/20 21:11:15', 0, 2, null, null, 058, 24, 1)
Insert into Booking values(108, 'B', '2022/01/20 21:15:05', 1, 2, null, null, 061, 9, 4)
Insert into Booking values(109, 'C', '2022/01/20 21:48:48', 0, 3, null, 75.00, 062, 5, 3)
Insert into Booking values(110, 'B', '2022/01/20 21:50:59', 0, 2, null, 60.00, 065, 8, 4)
Insert into Booking values(111, 'C', '2022/01/20 22:00:00', 0, 2, null, null, 069, 24, 1)
Insert into Booking values(112, 'B', '2022/01/20 22:22:22', 2, 2, 40.00, 60.00, 069, 7, 3)
Insert into Booking values(113, 'B', '2022/01/20 22:30:30', 0, 2, null, 60.00, 071, 7, 4)
Insert into Booking values(114, 'B', '2022/01/20 23:11:15', 0, 3, null, null, 074, 19, 1)
Insert into Booking values(115, 'B', '2022/01/20 23:15:15', 0, 2, null, 20.00, 076, 1, 2)
Insert into Booking values(116, 'P', '2022/01/20 23:25:15', 0, 2, null, null, 076, 24, 1)
Insert into Booking values(117, 'B', '2022/01/20 23:30:13', 1, 2, 30.00, 60.00, 076, 8, 3)
Insert into Booking values(118, 'B', '2022/01/20 00:00:00', 0, 1, null, null, 079, 11, 4)
Insert into Booking values(119, 'B', '2022/01/21 08:30:11', 0, 5, null, 75.00, 080, 6, 5)
Insert into Booking values(120, 'P', '2022/01/21 08:45:11', 0, 1, null, null, 085, 24, 1)
Insert into Booking values(121, 'C', '2022/01/21 08:55:55', 0, 2, null, null, 086, 22, 1)
Insert into Booking values(122, 'P', '2022/01/21 08:59:54', 0, 4, null, null, 088, 15, 2)
Insert into Booking values(123, 'B', '2022/01/21 09:30:11', 0, 1, null, null, 092, 9, 5)
Insert into Booking values(124, 'B', '2022/01/21 09:31:55', 0, 4, null, null, 093, 10, 5)
Insert into Booking values(125, 'B', '2022/01/21 09:45:14', 0, 2, null, null, 099, 11, 5)
Insert into Booking values(126, 'P', '2022/01/21 09:58:58', 0, 2, null, 20.00, 0100, 2, 2)
Insert into Booking values(127, 'B', '2022/01/21 10:00:11', 1, 1, null, null, 101, 17, 1)
Insert into Booking values(128, 'C', '2022/01/21 11:00:10', 1, 1, null, null, 103, 17, 1)
Insert into Booking values(129, 'B', '2022/01/21 12:30:12', 0, 2, null, null, 105, 25, 1)
Insert into Booking values(130, 'B', '2022/01/21 13:30:30', 0, 2, null, null, 108, 25, 1)
Insert into Booking values(131, 'B', '2022/01/21 14:22:45', 0, 2, null, null, 113, 25, 1)
Insert into Booking values(132, 'B', '2022/01/21 15:30:11', 1, 1, null, null, 103, 9, 6)
Insert into Booking values(133, 'P', '2022/01/21 15:30:11', 1, 1, null, null, 111, 9, 6)
Insert into Booking values(134, 'B', '2022/01/21 16:45:42', 2, 1, 60.00, 30.00, 001, 8, 5)
Insert into Booking values(135, 'P', '2022/01/21 17:55:11', 2, 2, 30.00, 40.00, 113, 3, 5)
Insert into Booking values(136, 'B', '2022/01/21 17:56:11', 1, 1, 20.00, 25.00, 117, 5, 4)
Insert into Booking values(137, 'B', '2022/01/21 20:55:20', 1, 1, 15.00, 20.00, 119, 3, 4)
Insert into Booking values(138, 'B', '2022/01/21 22:20:20', 0, 4, null, 100.00, 045, 5, 4)
select * from Booking /* Total: 138 */

/* Insert Dish */
Insert into Dish values(1, 'Caesar Salad', 'A Caesar salad is a green salad mixed with a variety of vegetables and cheese with pepper', 6, 1)
Insert into Dish values(2, 'Scrambled Eggs', 'Simple breakfast meal with eggs scrambled in a pan', 12, 1)
Insert into Dish values(3, 'Spaghetti', 'Spaghett is a staple food of Italian cuisine made of milled wheat and water', 6, 2)
Insert into Dish values(4, 'French Toast w/ Bacon/Sausage/Ham', 'Breakfast set meal that comes with a delicious offering of meat and bread', 12, 2)
Insert into Dish values(5, 'Roti Canai', 'Indian Muslim-influenced flatbread dish found in several countries in Southeast Asia', 4, 2)
Insert into Dish values(6, 'Fishball Noodles', 'Chinese breakfast/lunch staple, simple mix of noodles and fishballs', 1, 3)
Insert into Dish values(7, 'Moussaka', 'Moussaka is a creamy delicious dish made of spiced meat (beef or lamb) ', 7, 3)
Insert into Dish values(8, 'Stifado', 'Cooked with tomatoes, onions, cinnamon, vinegar or red wine, and a variety of spices and herbs.', 7, 3)
Insert into Dish values(9, 'Kleftiko', 'This Greek dish is slow oven cooked lamb infused with olive oil, lemon juice, and garlic.', 7, 4)
Insert into Dish values(10, 'Sweet and Sour Pork/Chicken with Rice', 'Sweet and sour mix of bursting flavour. Pork can be changed to chicken', 1, 4)
Insert into Dish values(11, 'Spring Rolls', 'Spring rolls are fried pancakes with different fillings with crispy skin.', 1, 5)
Insert into Dish values(12, 'Cantonese Fried Rice', 'Dish with boiled rice that is mixed with scallions and minced meat and quickly scrambled with eggs.', 1, 5)
Insert into Dish values(13, 'Fujian Fried Rice', 'Rice with braised shrimp, chicken, mushroom, scallops, carrot, egg, tomato, and potato starch are made into a sauce.', 1, 6)
Insert into Dish values(14, 'Hot Pot', 'A hot pot is a stew of meat and vegetables cooked in a simmering pot of soup stock.', 1, 6)
Insert into Dish values(15, 'Udon', 'One of the three main noodle varieties eaten in Japan; udon noodles are thick, chewy, and traditionally made from wheat flour and brine water.', 2, 7)
Insert into Dish values(16, 'Tempura', 'Tempura are pieces or slices of meat, fish, and/or vegetables that have been covered in a special tempura batter and deep fried until they become crunchy and pale gold in colour. ', 2, 7)
Insert into Dish values(17, 'Sashimi', 'Sashimi is raw fish or meat that has been expertly cut into thin slices and typically comes served with daikon radish, pickled ginger, wasabi and soy sauce.', 2, 7)
Insert into Dish values(18, 'Sushi', 'Dish made with Japanese rice that has been seasoned with rice vinegar topped off with fish.', 2, 8)
Insert into Dish values(19, 'French onion soup', 'A fragrant French onion soup with scrumptious cheesy croutons.', 3, 8)
Insert into Dish values(20, 'Bouillabaisse', 'This traditional French fish soup is infused with saffron, orange, thyme and chilli.', 3, 8)
Insert into Dish values(21, 'Cassoulet', 'Cassoulet, a hearty slow-simmered stew of sausage, confit (typically duck), pork, and white beans', 3, 8)
Insert into Dish values(22, 'Lamb shank navarin', 'Navarin is a French lamb ragout (or stew). The lamb is cooked low and slow until it melts in the mouth.', 3, 9)
Insert into Dish values(23, 'Masala dosa', 'Dosas are made from a thin batter consisting of rice, flour and lentils.', 4, 9)
Insert into Dish values(24, 'Stuffed paratha', 'After leaving the dough to rest overnight, parathas are made by cooking the dough on a tava before shallow frying. ', 4, 9)
Insert into Dish values(25, 'Chicken Makhani', 'It’s traditionally cooked in a tandoor (a cylindrical clay or metal oven), but may be grilled, roasted or pan-fried in less authentic preparations.', 4, 10)
Insert into Dish values(26, 'Mee goreng mamak', 'Yellow noodles. Beef or chicken. Shrimp. Soy sauce, veggies and eggs. ', 5, 10)
Insert into Dish values(27, 'Nasi lemak', 'Nasi lemak is basically rice cooked in coconut milk comes with hard-boiled egg, peanuts, vegetables, lamb/chicken/or beef curry, seafood and sambal', 5, 10)
Insert into Dish values(28, 'Nasi kandar', 'Nasi kandar is rice served with your choice of toppings, which commonly include curry, fish, egg and okra. ', 5, 10)
Insert into Dish values(29, 'Risotto', 'Creamy and rich in cheese, it is prepared with rice typical of northern areas and cooked slowly in broth.', 6, 11)
Insert into Dish values(30, 'Lasagne', 'This baked dish, typical of Bologna, is made up of layers of fresh pasta covered in béchamel sauce and the famous “ragù bolognese".', 6, 11)
Insert into Dish values(31, 'Bagna cauda', 'A typical Piedmontese dish, bagna cauda is a preparation based on extra virgin olive oil, anchovies, and garlic, all reduced to a sauce after long cooking.', 6, 11)
Insert into Dish values(32, 'Spanakopita', 'Spanikopita, otherwise known as ‘Greek spinach pie’, can be eaten any time of the day, breakfast and dinner, or as a starter or snack.', 7, 12)
Insert into Dish values(33, 'Feta Cheese with Honey', 'The feta cheese is wrapped in layers of phyllo and after it’s baked, some Greek honey is drizzled over it and it’s topped with a sprinkle of sesame seeds. ', 7, 13)
Insert into Dish values(34, 'Gazpacho', 'The reddest, ripest tomatoes, olive oil, garlic, bread, peppers and cucumber are blended until silky smooth, then chilled and poured into bowls.', 8, 13)
Insert into Dish values(35, 'Paella', 'Ingredients for paella Valenciana include chicken or rabbit, saffron, runner beans and butter beans.', 8, 13)
Insert into Dish values(36, 'Pisto', 'Onions, garlic, courgettes, peppers and tomatoes are slow fried in olive oil.', 8, 13)
Insert into Dish values(37, 'Tom yum goong', 'Tom yum goong is a bold, refreshing blend of fragrant lemongrass, chilli, galangal, kaffir lime leaves, shallots, lime juice, and fish sauce.', 9, 14)
Insert into Dish values(38, 'Tom kha kai', 'Tom kha kai infuses fiery chillies, thinly sliced young galangal, crushed shallots, stalks of lemongrass, and tender strips of chicken.', 9, 14)
Insert into Dish values(39, 'Gaeng daeng', 'Gaeng daeng is an aromatic red curry containing meat, red curry paste and smooth coconut milk, along with a sprinkling of sliced kaffir lime leaves on top.', 9, 14)
Insert into Dish values(40, 'Baklava', 'This layered pastry is filled with nuts and covered in syrup and ground pistachios for an unforgettable Mediterranean dessert', 10, 15)
Insert into Dish values(41, 'Şiş kebap', 'Traditionally made of beef or lamb, today diners can choose from a wider selection of meat, fish, poultry and vegetarian options, grilled over charcoal and served on metal or wooden skewers.', 10, 15)
Insert into Dish values(42, 'Köfte', 'Turkish meatballs come in all shapes and sizes, and can be eaten solo as street snacks, dipped in plain yoghurt or served with rice and salad.' , 10, 15)
Insert into Dish values(43, 'Bibimbap', 'The most common bibimbap consists of warm rice topped with mixed vegetables, beef or chicken, and raw egg, as well as soy sauce and a dollop of chilli pepper paste for seasoning.', 11, 1)
Insert into Dish values(44, 'Red rice cakes', 'Made with thick slices of garaetteok (boiled rice cake), fish cake, onions, diced garlic, salt, sugar and assorted vegetables that are stir-fried in sweet red chili sauce.', 11, 2)
Insert into Dish values(45, 'Korean stew (jjigae)', 'Contains meat, seafood or vegetables in a broth seasoned with hot pepper paste (gochujang), fermented miso (gaenjang), soybean paste, or salted fermented shrimp (saeujeot).', 11, 3)
Insert into Dish values(46, 'Lobster thermidor', 'The dish heroes the sweet meat of the crustacean combined with egg yolks and brandy or cognac which is then stuffed into a lobster shell.', 12, 4)
Insert into Dish values(47, 'Roast chicken', 'There are a myriad accompaniments for roast chicken – from healthy roasted herbed carrots, roasted asparagus with nuts and cheese, or spicy brussels sprouts with mint to heartier fare', 12, 5)
Insert into Dish values(48, 'Filet mignon', 'Filet mignon is usually served with buttery mashed potatoes, and assorted vegetables such as beans, asparagus, carrots, and mushrooms.' , 12, 6)
Insert into Dish values(49, 'Murtabak', 'This pan-fried bread stuffed with minced meat and onions and dipped in spicy sauce is a meal and a half.' , 5, 7)
Insert into Dish values(50, 'Pancakes', ' Pancakes are made from a starch-based batter that consists of eggs, milk, and butter.' , 12, 8)
select * from dish /* Total: 50 */

/* Insert categorised_in */
Insert into categorised_in values(9, 1)
Insert into categorised_in values(10, 1)
Insert into categorised_in values(1, 2)
Insert into categorised_in values(2, 2)
Insert into categorised_in values(4, 2)
Insert into categorised_in values(6, 2)
Insert into categorised_in values(10, 2)
Insert into categorised_in values(5, 3)
Insert into categorised_in values(4, 3)
Insert into categorised_in values(7, 3)
Insert into categorised_in values(6, 4)
Insert into categorised_in values(10, 4)
Insert into categorised_in values(4, 5)
Insert into categorised_in values(5, 5)
Insert into categorised_in values(7, 6)
Insert into categorised_in values(11, 6)
Insert into categorised_in values(11, 7)
Insert into categorised_in values(6, 8)
Insert into categorised_in values(13, 8)
Insert into categorised_in values(13, 9)
Insert into categorised_in values(13, 10)
Insert into categorised_in values(1, 11)
Insert into categorised_in values(10, 11)
Insert into categorised_in values(6, 12)
Insert into categorised_in values(13, 12)
Insert into categorised_in values(6, 13)
Insert into categorised_in values(13, 13)
Insert into categorised_in values(11, 14)
Insert into categorised_in values(13, 14)
Insert into categorised_in values(7, 15)
Insert into categorised_in values(13, 15)
Insert into categorised_in values(10, 16)
Insert into categorised_in values(13, 16)
Insert into categorised_in values(2, 17)
Insert into categorised_in values(10, 17)
Insert into categorised_in values(2, 18)
Insert into categorised_in values(10, 18)
Insert into categorised_in values(6, 18)
Insert into categorised_in values(12, 19)
Insert into categorised_in values(1, 19)
Insert into categorised_in values(3, 20)
Insert into categorised_in values(12, 20)
Insert into categorised_in values(2, 21)
Insert into categorised_in values(13, 22)
Insert into categorised_in values(5, 23)
Insert into categorised_in values(10, 24)
Insert into categorised_in values(5, 24)
Insert into categorised_in values(5, 25)
Insert into categorised_in values(10, 25)
Insert into categorised_in values(7, 26)
Insert into categorised_in values(4, 26)
Insert into categorised_in values(13, 27)
Insert into categorised_in values(4, 27)
Insert into categorised_in values(4, 28)
Insert into categorised_in values(13, 28)
Insert into categorised_in values(6, 29)
Insert into categorised_in values(1, 29)
Insert into categorised_in values(7, 30)
Insert into categorised_in values(13, 30)
Insert into categorised_in values(1, 31)
Insert into categorised_in values(6, 31)
Insert into categorised_in values(10, 32)
Insert into categorised_in values(6, 32)
Insert into categorised_in values(10, 33)
Insert into categorised_in values(3, 33)
Insert into categorised_in values(3, 34)
Insert into categorised_in values(4, 34)
Insert into categorised_in values(6, 34)
Insert into categorised_in values(13, 35)
Insert into categorised_in values(3, 36)
Insert into categorised_in values(6, 36)
Insert into categorised_in values(7, 37)
Insert into categorised_in values(2, 37)
Insert into categorised_in values(13, 38)
Insert into categorised_in values(13, 39)
Insert into categorised_in values(6, 39)
Insert into categorised_in values(10, 40)
Insert into categorised_in values(6, 40)
Insert into categorised_in values(8, 40)
Insert into categorised_in values(1, 41)
Insert into categorised_in values(3, 41)
Insert into categorised_in values(10, 42)
Insert into categorised_in values(13, 42)
Insert into categorised_in values(13, 43)
Insert into categorised_in values(2, 44)
Insert into categorised_in values(13, 45)
Insert into categorised_in values(13, 46)
Insert into categorised_in values(6, 46)
Insert into categorised_in values(6, 47)
Insert into categorised_in values(13, 47)
Insert into categorised_in values(6, 48)
Insert into categorised_in values(13, 48)
select * from categorised_in /* Total: 92 */

/* Insert contain */
Insert into contain values(37,1)
Insert into contain values(14,1)
Insert into contain values(9,1)
Insert into contain values(11,1)
Insert into contain values(36,1)
Insert into contain values(8,1)

Insert into contain values(5,2)
Insert into contain values(9,2)
Insert into contain values(36,2)
Insert into contain values(8,2)
Insert into contain values(37,2)
Insert into contain values(25,2)

Insert into contain values(5,3)
Insert into contain values(31,3)
Insert into contain values(37,3)
Insert into contain values(35,3)
Insert into contain values(36,3)
Insert into contain values(18,3)

Insert into contain values(12,4)
Insert into contain values(24, 4)
Insert into contain values(38,4)
Insert into contain values(1, 4)
Insert into contain values(4 ,4)

Insert into contain values(38,5)
Insert into contain values(26,5)
Insert into contain values(5, 5)

Insert into contain values(20, 6)
Insert into contain values(5, 6)
Insert into contain values(31, 6)
Insert into contain values(37, 6)

Insert into contain values(21, 7)
Insert into contain values(2, 7)
Insert into contain values(27, 7)
Insert into contain values(25, 7)

Insert into contain values(16, 8)
Insert into contain values(37, 8)
Insert into contain values(27, 8)
Insert into contain values(29, 8)

Insert into contain values(21, 9)
Insert into contain values(5, 9)
Insert into contain values(15, 9)
Insert into contain values(35, 9)
Insert into contain values(37, 9)

Insert into contain values(4, 10)
Insert into contain values(37, 10)
Insert into contain values(16, 10)
Insert into contain values(28, 10)
Insert into contain values(29, 10)

Insert into contain values(11, 11)
Insert into contain values(13, 11)
Insert into contain values(15, 11)
Insert into contain values(16, 11)
Insert into contain values(27, 11)

Insert into contain values(10, 12)
Insert into contain values(5, 12)
Insert into contain values(16, 12)
Insert into contain values(9, 12)
Insert into contain values(1, 12)
Insert into contain values(8, 12)

Insert into contain values(10, 13)
Insert into contain values(19, 13)
Insert into contain values(18, 13)
Insert into contain values(9, 13)
Insert into contain values(8, 13)
Insert into contain values(37, 13)
Insert into contain values(35, 13)

Insert into contain values(1, 14)
Insert into contain values(2, 14)
Insert into contain values(3, 14)
Insert into contain values(5, 14)
Insert into contain values(10, 14)
Insert into contain values(15, 14)
Insert into contain values(21, 14)
Insert into contain values(20, 14)

Insert into contain values(31, 15)
Insert into contain values(6, 15)
Insert into contain values(37, 15)
Insert into contain values(5, 15)

Insert into contain values(1, 16)
Insert into contain values(2, 16)
Insert into contain values(20, 16)
Insert into contain values(11, 16)
Insert into contain values(17, 16)

Insert into contain values(20, 17)
Insert into contain values(13, 17)
Insert into contain values(4, 17)
Insert into contain values(39, 17)
Insert into contain values(40, 17)

Insert into contain values(20, 18)
Insert into contain values(13, 18)
Insert into contain values(4, 18)
Insert into contain values(39, 18)
Insert into contain values(40, 18)
Insert into contain values(10, 18)

Insert into contain values(11, 19)
Insert into contain values(14, 19)
Insert into contain values(16, 19)
Insert into contain values(25, 19)

Insert into contain values(37, 20)
Insert into contain values(27, 20)
Insert into contain values(23, 20)

Insert into contain values(4, 21)
Insert into contain values(1, 21)
Insert into contain values(3, 21)
Insert into contain values(8, 21)
Insert into contain values(40, 21)

Insert into contain values(21, 22)
Insert into contain values(11, 22)
Insert into contain values(27, 22)
Insert into contain values(10, 22)
Insert into contain values(35, 22)

Insert into contain values(10, 23)
Insert into contain values(6, 23)
Insert into contain values(5, 23)
Insert into contain values(34, 23)
Insert into contain values(27, 23)

Insert into contain values(5, 24)
Insert into contain values(1, 24)

Insert into contain values(1, 25)
Insert into contain values(11, 25)
Insert into contain values(15, 25)
Insert into contain values(16, 25)
Insert into contain values(37, 25)

Insert into contain values(31, 26)
Insert into contain values(1, 26)
Insert into contain values(2, 26)
Insert into contain values(40, 26)
Insert into contain values(37, 26)
Insert into contain values(9, 26)

Insert into contain values(25, 27)
Insert into contain values(37, 27)
Insert into contain values(1, 27)
Insert into contain values(27, 27)
Insert into contain values(9, 27)
Insert into contain values(20, 27)
Insert into contain values(11, 27)
Insert into contain values(10, 27)

Insert into contain values(1, 28)
Insert into contain values(5, 28)
Insert into contain values(27, 28)
Insert into contain values(10, 28)
Insert into contain values(20, 28)

Insert into contain values(25, 29)
Insert into contain values(10, 29)
Insert into contain values(17, 29)
Insert into contain values(16, 29)

Insert into contain values(31, 30)
Insert into contain values(33, 30)
Insert into contain values(40, 30)
Insert into contain values(30, 30)

Insert into contain values(5, 31)
Insert into contain values(15, 31)
Insert into contain values(13, 31)

Insert into contain values(37, 32)
Insert into contain values(36, 32)
Insert into contain values(33, 32)
Insert into contain values(8, 32)

Insert into contain values(32, 33)
Insert into contain values(14, 33)
Insert into contain values(8, 33)

Insert into contain values(37, 34)
Insert into contain values(5, 34)
Insert into contain values(15, 34)
Insert into contain values(38, 34)
Insert into contain values(36, 34)

Insert into contain values(1, 35)
Insert into contain values(12, 35)
Insert into contain values(36, 35)
Insert into contain values(8, 35)

Insert into contain values(15, 36)
Insert into contain values(16, 36)
Insert into contain values(37, 36)
Insert into contain values(36, 36)
Insert into contain values(5, 36)

Insert into contain values(31, 37)
Insert into contain values(20, 37)
Insert into contain values(27, 37)
Insert into contain values(37, 37)
Insert into contain values(8, 37)
Insert into contain values(11, 37)

Insert into contain values(27, 38)
Insert into contain values(1, 38)
Insert into contain values(5, 38)
Insert into contain values(37, 38)
Insert into contain values(39, 38)

Insert into contain values(33, 39)
Insert into contain values(1, 39)
Insert into contain values(27, 39)
Insert into contain values(25, 39)

Insert into contain values(41, 40)
Insert into contain values(42, 40)

Insert into contain values(2, 41)
Insert into contain values(21, 41)
Insert into contain values(20, 41)
Insert into contain values(37, 41)

Insert into contain values(37, 42)
Insert into contain values(2, 42)
Insert into contain values(10, 42)

Insert into contain values(37, 43)
Insert into contain values(1, 43)
Insert into contain values(10, 43)
Insert into contain values(2, 43)
Insert into contain values(40, 43)
Insert into contain values(9, 43)
Insert into contain values(27, 43)
Insert into contain values(36, 43)
Insert into contain values(8, 43)

Insert into contain values(10, 44)
Insert into contain values(16, 44)
Insert into contain values(37, 44)
Insert into contain values(15, 44)
Insert into contain values(7, 44)
Insert into contain values(8, 44)

Insert into contain values(1, 45)
Insert into contain values(20, 45)
Insert into contain values(37, 45)
Insert into contain values(26, 45)
Insert into contain values(19, 45)

Insert into contain values(9, 46)
Insert into contain values(20, 46)
Insert into contain values(19, 46)

Insert into contain values(1, 47)
Insert into contain values(37, 47)
Insert into contain values(41, 47)
Insert into contain values(14, 47)

Insert into contain values(13, 48)
Insert into contain values(35, 48)
Insert into contain values(20, 48)
Insert into contain values(37, 48)
Insert into contain values(18, 48)

Insert into contain values(2, 49)
Insert into contain values(16, 49)
Insert into contain values(26, 49)
Insert into contain values(5, 49)
Insert into contain values(38, 49)

Insert into contain values(12, 50)
Insert into contain values(42, 50)
Insert into contain values(30, 50)
Insert into contain values(5, 50)
Insert into contain values(8, 50)
select * from contain /* Total: 240 */

select DishName, IngredName from contain c inner join Ingredient i on c.IngredID = i.IngredID inner join Dish d on c.DishID = d.DishID where c.DishID = '5'

/*Insert CSDish */
Insert into CSDish values(1, 15.0)
Insert into CSDish values(2, 3.5)
Insert into CSDish values(3, 11.0)
Insert into CSDish values(4, 7.5)
Insert into CSDish values(5, 9.0)
Insert into CSDish values(7, 12.0)
Insert into CSDish values(10, 11.5)
Insert into CSDish values(11, 5.5)
Insert into CSDish values(12, 10.5)
Insert into CSDish values(13, 10.5)
Insert into CSDish values(16, 14.5)
Insert into CSDish values(18, 4.0)
Insert into CSDish values(19, 8.5)
Insert into CSDish values(20, 9.0)
Insert into CSDish values(22, 15.5)
Insert into CSDish values(23, 11.0)
Insert into CSDish values(25, 13.0)
Insert into CSDish values(26, 10.5)
Insert into CSDish values(27, 10.0)
Insert into CSDish values(28, 10.0)
Insert into CSDish values(29, 12.5)
Insert into CSDish values(30, 12.5)
Insert into CSDish values(32, 10.5)
Insert into CSDish values(34, 12.5)
Insert into CSDish values(39, 15.5)
Insert into CSDish values(40, 13.5)
Insert into CSDish values(41, 12.5)
Insert into CSDish values(43, 10.5)
Insert into CSDish values(44, 5.5)
Insert into CSDish values(46, 35.0)
Insert into CSDish values(47, 14.5)
Insert into CSDish values(49, 12.5)
Insert into CSDish values(50, 10.0)
select * from CSDish /* Total: 33 */

/* Insert orders */
--lunch
Insert into orders values(062, 2, '2022/01/20 11:50:00', '2022/01/20 12:00:00', 3, 10.5, 026)
Insert into orders values(062, 7, '2022/01/20 11:50:00', '2022/01/20 12:00:00', 1, 12.0, 026)
Insert into orders values(062, 16, '2022/01/20 11:50:00', '2022/01/20 12:00:00', 1, 14.5, 026)
Insert into orders values(062, 32, '2022/01/20 11:50:00', '2022/01/20 12:00:00', 1, 10.5, 026)

Insert into orders values(065, 46, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 2, 70.0, 027)
Insert into orders values(065, 20, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 2, 18.0, 027)

Insert into orders values(069, 18, '2022/01/20 11:00:00', '2022/01/20 11:20:00', 3, 12.0, 028)
Insert into orders values(069, 1, '2022/01/20 11:00:00', '2022/01/20 11:20:00', 1, 15.0, 028)
Insert into orders values(069, 26, '2022/01/20 11:00:00', '2022/01/20 11:20:00', 2, 21.0, 028)
Insert into orders values(069, 40, '2022/01/20 11:00:00', '2022/01/20 11:20:00', 1, 13.5, 028)
Insert into orders values(069, 44, '2022/01/20 11:00:00', '2022/01/20 11:20:00', 4, 22.0, 028)

Insert into orders values(075, 5, '2022/01/20 12:10:00', '2022/01/20 12:35:00', 2, 18.0, 029)
Insert into orders values(075, 29, '2022/01/20 12:10:00', '2022/01/20 12:35:00', 2, 25.0, 029)
Insert into orders values(075, 19, '2022/01/20 12:10:00', '2022/01/20 12:35:00', 1, 8.5, 029)
Insert into orders values(075, 18, '2022/01/20 12:10:00', '2022/01/20 12:35:00', 4, 16.0, 029)

Insert into orders values(076, 17, '2022/01/20 10:20:00', '2022/01/20 11:45:00', 1, 10.0, 030)
Insert into orders values(076, 10, '2022/01/20 10:20:00', '2022/01/20 11:45:00', 1, 11.5, 030)
Insert into orders values(076, 2, '2022/01/20 10:20:00', '2022/01/20 11:45:00', 3, 10.5, 030)
Insert into orders values(076, 26, '2022/01/20 10:20:00', '2022/01/20 11:45:00', 1, 10.5, 030)

Insert into orders values(079, 19, '2022/01/20 12:00:00', '2022/01/20 12:10:00', 1, 17.0, 031)
Insert into orders values(079, 2, '2022/01/20 12:00:00', '2022/01/20 12:10:00', 2, 7, 031)

Insert into orders values(083, 1, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 2, 30.0, 032)
Insert into orders values(083, 46, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 1, 35.0, 032)
Insert into orders values(083, 39, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 1, 15.5, 032)
Insert into orders values(083, 2, '2022/01/20 11:25:00', '2022/01/20 11:35:00', 2,  7.0, 032)

Insert into orders values(085, 2, '2022/01/20 12:25:00', '2022/01/20 12:35:00', 1, 3.5, 033)

Insert into orders values(086, 46, '2022/01/20 12:45:00', '2022/01/20 12:55:00', 1, 35.0, 034)
Insert into orders values(086, 11, '2022/01/20 12:45:00', '2022/01/20 12:55:00', 1, 5.5, 034)

Insert into orders values(090, 25, '2022/01/20 11:10:00', '2022/01/20 11:15:00', 1, 13.0, 035)
Insert into orders values(090, 20, '2022/01/20 10:10:00', '2022/01/20 11:15:00', 1, 9.0, 035)
Insert into orders values(090, 18, '2022/01/20 10:10:00', '2022/01/20 11:15:00', 2, 8.0, 035)
Insert into orders values(090, 49, '2022/01/20 10:10:00', '2022/01/20 11:15:00', 1, 12.5, 035)
Insert into orders values(090, 50, '2022/01/20 10:10:00', '2022/01/20 11:15:00', 1, 10.0, 035)
Insert into orders values(090, 44, '2022/01/20 10:10:00', '2022/01/20 11:15:00', 3, 16.5, 035)

Insert into orders values(092, 1, '2022/01/20 11:00:00', '2022/01/20 11:10:00', 1, 15.00, 036)
Insert into orders values(092, 2, '2022/01/20 11:05:00', '2022/01/20 11:10:00', 1, 3.50, 036)

Insert into orders values(093, 3, '2022/01/20 12:00:00', '2022/01/20 12:15:00', 2, 44.00, 037)
Insert into orders values(095, 4, '2022/01/20 12:01:00', '2022/01/20 12:17:11', 2, 15.00, 037)

Insert into orders values(097, 5, '2022/01/20 11:55:00', '2022/01/20 12:05:05', 1, 9.00, 038)
Insert into orders values(097, 7, '2022/01/20 12:00:00', '2022/01/20 12:18:55', 1, 12.00, 038)

Insert into orders values(099, 10, '2022/01/20 12:12:12', '2022/01/20 12:40:00', 2, 23.00, 039)
Insert into orders values(099, 11, '2022/01/20 12:15:00', '2022/01/20 12:40:00', 2, 11.00, 039)

Insert into orders values(101, 12, '2022/01/20 12:18:18', '2022/01/20 12:42:00', 1, 10.50, 040)
Insert into orders values(101, 13, '2022/01/20 12:20:12', '2022/01/20 12:42:00', 1, 10.50, 040)

Insert into orders values(103, 43, '2022/01/20 12:30:00', '2022/01/20 12:50:50', 2, 21.00, 041)
Insert into orders values(103, 34, '2022/01/20 12:33:12', '2022/01/20 12:50:50', 1, 12.50, 041)

Insert into orders values(105, 16, '2022/01/20 12:10:10', '2022/01/20 12:30:00', 2, 29.00, 042)
Insert into orders values(105, 18, '2022/01/20 12:13:55', '2022/01/20 12:30:00', 3, 12.00, 042)
Insert into orders values(105, 19, '2022/01/20 12:15:59', '2022/01/20 12:30:00', 3, 25.50, 042)

Insert into orders values(108, 20, '2022/01/20 11:30:00', '2022/01/20 11:55:01', 3, 27.00, 043)
Insert into orders values(108, 22, '2022/01/20 11:33:33', '2022/01/20 11:55:01', 1, 15.50, 043)
Insert into orders values(108, 23, '2022/01/20 11:35:55', '2022/01/20 11:55:01', 2, 22.00, 043)

Insert into orders values(111, 25, '2022/01/20 12:15:59', '2022/01/20 12:30:00', 2, 26.00, 044)

Insert into orders values(113, 26, '2022/01/20 12:30:09', '2022/01/20 12:50:00', 1, 10.50, 045)
Insert into orders values(113, 27, '2022/01/20 12:32:22', '2022/01/20 12:50:00', 1, 10.00, 045)
Insert into orders values(113, 28, '2022/01/20 12:33:59', '2022/01/20 12:50:00', 1, 10.00, 045)
Insert into orders values(113, 29, '2022/01/20 12:35:11', '2022/01/20 12:50:00', 1, 12.50, 045)

Insert into orders values(117, 30, '2022/01/20 12:55:09', '2022/01/20 13:11:55', 2, 25.00, 046)

Insert into orders values(119, 32, '2022/01/20 12:00:00', '2022/01/20 12:30:22', 1, 10.50, 047)
Insert into orders values(119, 34, '2022/01/20 12:02:09', '2022/01/20 12:30:22', 1, 12.50, 047)
/* Total: 60 */

--dinner
Insert into orders values(062, 44, '2022/01/20 21:05:00', '2022/01/20 21:15:00', 2, 11.0, 026)
Insert into orders values(062, 46, '2022/01/20 21:05:00', '2022/01/20 21:15:00', 1, 35.0, 026)
Insert into orders values(062, 41, '2022/01/20 21:05:00', '2022/01/20 21:15:00', 2, 25.0, 026)

Insert into orders values(065, 7, '2022/01/20 20:35:00', '2022/01/20 20:45:00', 2, 24.0, 027)
Insert into orders values(065, 18, '2022/01/20 20:35:00', '2022/01/20 20:45:00', 1, 4.0, 027)

Insert into orders values(069, 2, '2022/01/20 21:20:00', '2022/01/20 21:30:00', 3, 10.5, 028)
Insert into orders values(069, 50, '2022/01/20 21:20:00', '2022/01/20 21:30:00', 2, 20.0, 028)
Insert into orders values(069, 25, '2022/01/20 21:20:00', '2022/01/20 21:30:00', 2, 26.0, 028)
Insert into orders values(069, 39, '2022/01/20 21:20:00', '2022/01/20 21:30:00', 1, 15.5, 028)

Insert into orders values(075, 12, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 2, 21.0, 029)
Insert into orders values(075, 30, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 2, 25.0, 029)
Insert into orders values(075, 2, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 1, 3.5, 029)
Insert into orders values(075, 18, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 4, 16.0, 029)

Insert into orders values(076, 5, '2022/01/20 21:10:00', '2022/01/20 21:15:00', 1, 9.0, 030)
Insert into orders values(076, 3, '2022/01/20 21:10:00', '2022/01/20 21:15:00', 1, 11.0, 030)
Insert into orders values(076, 47, '2022/01/20 21:10:00', '2022/01/20 21:15:00', 1, 14.5, 030)

Insert into orders values(079, 41, '2022/01/20 19:45:00', '2022/01/20 19:55:00', 1, 12.5, 031)
Insert into orders values(079, 44, '2022/01/20 19:45:00', '2022/01/20 19:55:00', 2, 10.5, 031)

Insert into orders values(083, 3, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 2, 22.0, 032)
Insert into orders values(083, 50, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 1, 10.0, 032)
Insert into orders values(083, 12, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 1, 10.5, 032)
Insert into orders values(083, 2, '2022/01/20 20:25:00', '2022/01/20 20:35:00', 3,  10.5, 032)

Insert into orders values(085, 13, '2022/01/20 20:30:00', '2022/01/20 20:35:00', 1, 10.5, 033)

Insert into orders values(086, 16, '2022/01/20 19:45:00', '2022/01/20 19:55:00', 1, 14.5, 034)
Insert into orders values(086, 7, '2022/01/20 19:45:00', '2022/01/20 19:55:00', 1, 12.0, 034)

Insert into orders values(090, 19, '2022/01/20 20:05:00', '2022/01/20 20:15:00', 2, 17.0, 035)
Insert into orders values(090, 18, '2022/01/20 20:05:00', '2022/01/20 20:15:00', 2, 8.0, 035)
Insert into orders values(090, 22, '2022/01/20 20:05:00', '2022/01/20 20:15:00', 1, 15.5, 035)
Insert into orders values(090, 1, '2022/01/20 20:05:00', '2022/01/20 20:15:00', 1, 15.0, 035)

Insert into orders values(092, 39, '2022/01/20 18:30:09', '2022/01/20 18:55:00', 1, 15.50, 036)

Insert into orders values(093, 40, '2022/01/20 18:00:00', '2022/01/20 18:22:00', 2, 27.00, 037)
Insert into orders values(093, 41, '2022/01/20 18:02:00', '2022/01/20 18:22:00', 2, 25.00, 037)
Insert into orders values(093, 43, '2022/01/20 18:05:00', '2022/01/20 18:22:00', 2, 21.00, 037)

Insert into orders values(097, 44, '2022/01/20 17:30:09', '2022/01/20 17:55:00', 2, 11.00, 038)
Insert into orders values(097, 46, '2022/01/20 17:32:00', '2022/01/20 17:55:00', 1, 35.00, 038)

Insert into orders values(099, 47, '2022/01/20 19:00:10', '2022/01/20 19:25:00', 2, 29.00, 039)

Insert into orders values(101, 49, '2022/01/20 17:55:55', '2022/01/20 18:10:59', 2, 25.00, 040)
Insert into orders values(101, 50, '2022/01/20 17:58:58', '2022/01/20 18:10:59', 2, 20.00, 040)

Insert into orders values(103, 46, '2022/01/20 18:05:10', '2022/01/20 18:30:00', 2, 70.00, 041)

Insert into orders values(105, 22, '2022/01/20 19:30:55', '2022/01/20 19:55:44', 2, 31.00, 042)
Insert into orders values(105, 27, '2022/01/20 19:32:15', '2022/01/20 19:55:44', 2, 20.00, 042)
Insert into orders values(105, 2, '2022/01/20 19:35:11', '2022/01/20 19:55:44', 3, 10.50, 042)

Insert into orders values(108, 10, '2022/01/20 18:45:00', '2022/01/20 19:00:00', 3, 34.50, 043)
Insert into orders values(108, 18, '2022/01/20 18:49:00', '2022/01/20 19:00:00', 3, 12.00, 043)

Insert into orders values(111, 43, '2022/01/20 17:45:00', '2022/01/20 18:10:00', 2, 21.00, 044)
Insert into orders values(111, 46, '2022/01/20 17:49:00', '2022/01/20 18:10:00', 1, 35.00, 044)

Insert into orders values(113, 28, '2022/01/20 18:55:00', '2022/01/20 19:20:20', 2, 20.00, 045)
Insert into orders values(113, 30, '2022/01/20 18:57:04', '2022/01/20 19:20:20', 2, 25.00, 045)
Insert into orders values(113, 34, '2022/01/20 18:59:59', '2022/01/20 19:20:20', 1, 12.50, 045)

Insert into orders values(117, 7, '2022/01/20 17:55:00', '2022/01/20 18:15:20', 2, 24.00, 046)

Insert into orders values(119, 16, '2022/01/20 18:55:00', '2022/01/20 19:15:20', 2, 29.00, 047)
/* Total: 51 */

--breakfast
Insert into orders values(062, 2, '2022/01/21 8:05:00', '2022/01/21 8:15:00', 4, 14.0, 026)

Insert into orders values(065, 50, '2022/01/21 8:35:00', '2022/01/21 8:45:00', 2, 20.0, 027)

Insert into orders values(069, 2, '2022/01/21 7:50:00', '2022/01/21 8:00:00', 3, 10.5, 028)
Insert into orders values(069, 43, '2022/01/21 7:50:00', '2022/01/21 8:00:00', 1, 10.0, 028)
Insert into orders values(069, 20, '2022/01/21 7:50:00', '2022/01/21 8:00:00', 1, 9.0, 028)

Insert into orders values(075, 4, '2022/01/21 9:10:00', '2022/01/21 9:15:00', 3, 22.5, 029)
Insert into orders values(075, 16, '2022/01/21 9:10:00', '2022/01/21 9:15:00', 1, 14.5, 029)

Insert into orders values(076, 2, '2022/01/21 9:55:00', '2022/01/21 10:00:00', 3, 10.5, 030)

Insert into orders values(079, 4, '2022/01/21 10:00:00', '2022/01/21 10:10:00', 2, 15.0, 031)

Insert into orders values(083, 4, '2022/01/21 8:25:00', '2022/01/21 8:35:00', 2, 15.0, 032)

Insert into orders values(085, 2, '2022/01/21 9:00:00', '2022/01/21 9:10:00', 2, 7.0, 033)

Insert into orders values(086, 2, '2022/01/21 9:55:00', '2022/01/21 10:00:00', 1, 3.5, 034)
Insert into orders values(086, 4, '2022/01/21 9:55:00', '2022/01/21 10:00:00', 1, 7.5, 034)

Insert into orders values(090, 4, '2022/01/21 9:10:00', '2022/01/21 9:15:00', 4, 30.0, 035)

Insert into orders values(092, 1, '2022/01/21 08:00:00', '2022/01/21 08:15:20', 1, 15.00, 036)

Insert into orders values(093, 4, '2022/01/21 09:01:00', '2022/01/21 09:28:11', 4, 30.00, 037)

Insert into orders values(097, 2, '2022/01/21 08:30:00', '2022/01/21 08:50:20', 2, 7.00, 038)

Insert into orders values(099, 3, '2022/01/21 08:15:00', '2022/01/21 08:30:00', 2, 22.00, 039)

Insert into orders values(101, 5, '2022/01/21 08:05:55', '2022/01/21 08:20:29', 2, 18.00, 040)

Insert into orders values(103, 11, '2022/01/21 09:00:00', '2022/01/21 09:15:20', 2, 11.00, 041)

Insert into orders values(105, 18, '2022/01/21 08:55:20', '2022/01/21 09:10:20', 3, 12.00, 042)
Insert into orders values(105, 19, '2022/01/21 08:58:30', '2022/01/21 09:10:20', 3, 25.50, 042)

Insert into orders values(108, 23, '2022/01/21 08:00:00', '2022/01/21 08:15:20', 3, 33.00, 043)

Insert into orders values(111, 27, '2022/01/21 08:55:00', '2022/01/21 09:15:20', 2, 20.00, 044)

Insert into orders values(113, 50, '2022/01/21 08:20:00', '2022/01/21 08:55:20', 4, 40.00, 045)

Insert into orders values(117, 44, '2022/01/21 09:20:00', '2022/01/21 09:55:20', 2, 11.00, 046)

Insert into orders values(119, 49, '2022/01/21 10:00:00', '2022/01/21 10:25:00', 2, 25.00, 047)
/* Total: 27 */

--lunch
Insert into orders values(062, 2, '2022/01/21 11:50:00', '2022/01/21 12:00:00', 3, 10.5, 026)
Insert into orders values(062, 7, '2022/01/21 11:50:00', '2022/01/21 12:00:00', 1, 12.0, 026)
Insert into orders values(062, 16, '2022/01/21 11:50:00', '2022/01/21 12:00:00', 1, 14.5, 026)
Insert into orders values(062, 32, '2022/01/21 11:50:00', '2022/01/21 12:00:00', 1, 10.5, 026)

Insert into orders values(065, 46, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 2, 70.0, 027)
Insert into orders values(065, 20, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 2, 18.0, 027)

Insert into orders values(069, 18, '2022/01/21 11:00:00', '2022/01/21 11:20:00', 3, 12.0, 028)
Insert into orders values(069, 1, '2022/01/21 11:00:00', '2022/01/21 11:20:00', 1, 15.0, 028)
Insert into orders values(069, 26, '2022/01/21 11:00:00', '2022/01/21 11:20:00', 2, 21.0, 028)
Insert into orders values(069, 40, '2022/01/21 11:00:00', '2022/01/21 11:20:00', 1, 13.5, 028)
Insert into orders values(069, 44, '2022/01/21 11:00:00', '2022/01/21 11:20:00', 4, 22.0, 028)

Insert into orders values(075, 5, '2022/01/21 12:10:00', '2022/01/21 12:35:00', 2, 18.0, 029)
Insert into orders values(075, 29, '2022/01/21 12:10:00', '2022/01/21 12:35:00', 2, 25.0, 029)
Insert into orders values(075, 19, '2022/01/21 12:10:00', '2022/01/21 12:35:00', 1, 8.5, 029)
Insert into orders values(075, 18, '2022/01/21 12:10:00', '2022/01/21 12:35:00', 4, 16.0, 029)

Insert into orders values(076, 17, '2022/01/21 10:20:00', '2022/01/21 11:45:00', 1, 10.0, 030)
Insert into orders values(076, 10, '2022/01/21 10:20:00', '2022/01/21 11:45:00', 1, 11.5, 030)
Insert into orders values(076, 2, '2022/01/21 10:20:00', '2022/01/21 11:45:00', 3, 10.5, 030)
Insert into orders values(076, 26, '2022/01/21 10:20:00', '2022/01/21 11:45:00', 1, 10.5, 030)

Insert into orders values(079, 19, '2022/01/21 12:00:00', '2022/01/21 12:10:00', 1, 17.0, 031)
Insert into orders values(079, 2, '2022/01/21 12:00:00', '2022/01/21 12:10:00', 2, 7, 031)

Insert into orders values(083, 1, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 2, 30.0, 032)
Insert into orders values(083, 46, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 1, 35.0, 032)
Insert into orders values(083, 39, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 1, 15.5, 032)
Insert into orders values(083, 2, '2022/01/21 11:25:00', '2022/01/21 11:35:00', 2,  7.0, 032)

Insert into orders values(085, 2, '2022/01/21 12:25:00', '2022/01/21 12:35:00', 1, 3.5, 033)

Insert into orders values(086, 46, '2022/01/21 12:45:00', '2022/01/21 12:55:00', 1, 35.0, 034)
Insert into orders values(086, 11, '2022/01/21 12:45:00', '2022/01/21 12:55:00', 1, 5.5, 034)

Insert into orders values(090, 25, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 1, 13.0, 035)
Insert into orders values(090, 20, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 1, 9.0, 035)
Insert into orders values(090, 18, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 2, 8.0, 035)
Insert into orders values(090, 49, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 1, 12.5, 035)
Insert into orders values(090, 50, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 1, 10.0, 035)
Insert into orders values(090, 44, '2022/01/21 11:10:00', '2022/01/21 11:15:00', 3, 16.5, 035)

Insert into orders values(092, 26, '2022/01/21 12:20:00', '2022/01/21 12:40:20', 1, 10.50, 036)

Insert into orders values(093, 22, '2022/01/21 13:20:00', '2022/01/21 13:45:20', 2, 31.00, 037)
Insert into orders values(093, 23, '2022/01/21 13:22:00', '2022/01/21 13:45:20', 2, 22.00, 037)

Insert into orders values(097, 10, '2022/01/21 11:20:00', '2022/01/21 11:39:20', 2, 23.00, 038)

Insert into orders values(099, 22, '2022/01/21 11:00:00', '2022/01/21 11:19:00', 2, 31.00, 039)

Insert into orders values(101, 18, '2022/01/21 11:30:00', '2022/01/21 11:59:00', 2, 8.00, 040)
Insert into orders values(101, 20, '2022/01/21 11:33:00', '2022/01/21 11:59:00', 2, 18.00, 040)

Insert into orders values(103, 47, '2022/01/21 12:00:00', '2022/01/21 12:20:20', 2, 29.00, 041)

Insert into orders values(105, 47, '2022/01/21 11:15:00', '2022/01/21 11:32:12', 2, 29.00, 042)
Insert into orders values(105, 43, '2022/01/21 11:18:18', '2022/01/21 11:32:12', 3, 31.50, 042)

Insert into orders values(108, 26, '2022/01/21 11:30:30', '2022/01/21 12:00:00', 1, 10.50, 043)
Insert into orders values(108, 27, '2022/01/21 11:32:40', '2022/01/21 12:00:00', 1, 10.00, 043)
Insert into orders values(108, 28, '2022/01/21 11:35:59', '2022/01/21 12:00:00', 1, 10.00, 043)

Insert into orders values(111, 47, '2022/01/21 11:00:00', '2022/01/21 11:22:50', 2, 29.00, 044)

Insert into orders values(113, 29, '2022/01/21 12:55:00', '2022/01/21 13:23:55', 2, 25.00, 045)
Insert into orders values(113, 30, '2022/01/21 12:55:00', '2022/01/21 13:23:55', 2, 25.00, 045)

Insert into orders values(117, 39, '2022/01/21 11:55:00', '2022/01/21 12:23:55', 2, 31.00, 046)

Insert into orders values(119, 43, '2022/01/21 12:55:00', '2022/01/21 13:23:55', 2, 21.00, 047)
/* Total: 52 */

--dinner 
Insert into orders values(062, 44, '2022/01/21 21:05:00', '2022/01/21 21:15:00', 2, 11.0, 026)
Insert into orders values(062, 46, '2022/01/21 21:05:00', '2022/01/21 21:15:00', 1, 35.0, 026)
Insert into orders values(062, 41, '2022/01/21 21:05:00', '2022/01/21 21:15:00', 2, 25.0, 026)

Insert into orders values(065, 7, '2022/01/21 20:35:00', '2022/01/21 20:45:00', 2, 24.0, 027)
Insert into orders values(065, 18, '2022/01/21 20:35:00', '2022/01/21 20:45:00', 1, 4.0, 027)

Insert into orders values(069, 2, '2022/01/21 21:20:00', '2022/01/21 21:30:00', 3, 10.5, 028)
Insert into orders values(069, 50, '2022/01/21 21:20:00', '2022/01/21 21:30:00', 2, 20.0, 028)
Insert into orders values(069, 25, '2022/01/21 21:20:00', '2022/01/21 21:30:00', 2, 26.0, 028)
Insert into orders values(069, 39, '2022/01/21 21:20:00', '2022/01/21 21:30:00', 1, 15.5, 028)

Insert into orders values(075, 12, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 2, 21.0, 029)
Insert into orders values(075, 30, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 2, 25.0, 029)
Insert into orders values(075, 2, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 1, 3.5, 029)
Insert into orders values(075, 18, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 4, 16.0, 029)

Insert into orders values(076, 5, '2022/01/21 21:10:00', '2022/01/21 21:15:00', 1, 9.0, 030)
Insert into orders values(076, 3, '2022/01/21 21:10:00', '2022/01/21 21:15:00', 1, 11.0, 030)
Insert into orders values(076, 47, '2022/01/21 21:10:00', '2022/01/21 21:15:00', 1, 14.5, 030)

Insert into orders values(079, 41, '2022/01/21 19:45:00', '2022/01/21 19:55:00', 1, 12.5, 031)
Insert into orders values(079, 44, '2022/01/21 19:45:00', '2022/01/21 19:55:00', 2, 10.5, 031)

Insert into orders values(083, 3, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 2, 22.0, 032)
Insert into orders values(083, 50, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 1, 10.0, 032)
Insert into orders values(083, 12, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 1, 10.5, 032)
Insert into orders values(083, 2, '2022/01/21 20:25:00', '2022/01/21 20:35:00', 3,  10.5, 032)

Insert into orders values(085, 13, '2022/01/21 20:30:00', '2022/01/21 20:35:00', 1, 10.5, 033)

Insert into orders values(086, 16, '2022/01/21 19:45:00', '2022/01/21 19:55:00', 1, 14.5, 034)
Insert into orders values(086, 7, '2022/01/21 19:45:00', '2022/01/21 19:55:00', 1, 12.0, 034)

Insert into orders values(090, 19, '2022/01/21 20:05:00', '2022/01/21 20:15:00', 2, 17.0, 035)
Insert into orders values(090, 18, '2022/01/21 20:05:00', '2022/01/21 20:15:00', 2, 8.0, 035)
Insert into orders values(090, 22, '2022/01/21 20:05:00', '2022/01/21 20:15:00', 1, 15.5, 035)
Insert into orders values(090, 1, '2022/01/21 20:05:00', '2022/01/21 20:15:00', 1, 15.0, 035)

Insert into orders values(092, 23, '2022/01/21 18:55:00', '2022/01/21 19:23:55', 1, 11.00, 036)

Insert into orders values(093, 29, '2022/01/21 17:55:00', '2022/01/21 18:23:55', 2, 25.00, 037)
Insert into orders values(093, 40, '2022/01/21 17:57:00', '2022/01/21 18:23:55', 2, 27.00, 037)

Insert into orders values(097, 34, '2022/01/21 17:30:00', '2022/01/21 18:45:11', 2, 25.00, 038)

Insert into orders values(099, 27, '2022/01/21 17:35:00', '2022/01/21 18:50:00', 2, 20.00, 039)

Insert into orders values(101, 1, '2022/01/21 18:30:00', '2022/01/21 18:45:11', 1, 15.00, 040)
Insert into orders values(101, 13, '2022/01/21 18:32:55', '2022/01/21 18:45:11', 1, 10.50, 040)

Insert into orders values(103, 25, '2022/01/21 19:30:00', '2022/01/21 19:45:19', 1, 13.00, 041)
Insert into orders values(103, 43, '2022/01/21 19:30:00', '2022/01/21 19:45:19', 1, 10.50, 041)

Insert into orders values(105, 18, '2022/01/21 19:00:00', '2022/01/21 19:20:22', 3, 12.00, 042)
Insert into orders values(105, 22, '2022/01/21 19:00:00', '2022/01/21 19:20:22', 2, 31.00, 042)
Insert into orders values(105, 26, '2022/01/21 19:00:00', '2022/01/21 19:20:22', 2, 21.00, 042)

Insert into orders values(108, 44, '2022/01/21 18:00:00', '2022/01/21 18:20:22', 3, 16.50, 043)
Insert into orders values(108, 46, '2022/01/21 18:00:00', '2022/01/21 18:20:22', 2, 70.00, 043)

Insert into orders values(111, 20, '2022/01/21 19:22:00', '2022/01/21 19:45:45', 2, 18.00, 044)
Insert into orders values(111, 22, '2022/01/21 19:22:00', '2022/01/21 19:45:45', 2, 31.00, 044)

Insert into orders values(113, 7, '2022/01/21 19:30:00', '2022/01/21 19:55:52', 2, 24.00, 045)
Insert into orders values(113, 12, '2022/01/21 19:33:40', '2022/01/21 19:55:52', 1, 10.50, 045)
Insert into orders values(113, 13, '2022/01/21 19:35:50', '2022/01/21 19:55:52', 1, 10.50, 045)

Insert into orders values(117, 26, '2022/01/21 18:40:00', '2022/01/21 19:00:58', 2, 21.00, 046)

Insert into orders values(119, 41, '2022/01/21 19:05:35', '2022/01/21 19:23:15', 2, 25.00, 047)
Insert into orders values(119, 43, '2022/01/21 19:05:05', '2022/01/21 19:23:15', 2, 21.00, 047)
/* Total: 51 */
select * from orders /* Total: 241 */
