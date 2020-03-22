
% offerMean(X, Y) -> Transportation mean Y is used with offer X

offerMean(offer(dahab, [diving, snorkeling, horseRiding], 10000, 2020-02-12, 2020-03-12, period(2020-03-15, 2020-04-15), 10, 5), bus).
offerMean(offer(taba, [diving], 1000, 2020-02-12, 2020-03-12, period(2020-06-01, 2020-08-31), 10, 4), bus).

% offerAccommodation(X, Y) -> Accommodation Y is part of offer X

offerAccommodation(offer(dahab, [diving, snorkeling, horseRiding], 10000, 2020-02-12, 2020-03-12, period(2020-03-15, 2020-04-15), 10, 5), hotel).
offerAccommodation(offer(taba, [diving], 1000, 2020-02-12, 2020-03-12, period(2020-06-01, 2020-08-31), 10, 4), hotel).

% customerPreferredActivity(X, Y, R) -> Y is the preferred activity kind wrt customer X with relevance R

customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), diving, 100).
customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), snorkeling, 100).
customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), horseRiding, 20).
customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), snorkeling, 60).
customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), diving, 20).
customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), horseRiding, 50).

% customerPreferredMean(X, Y, R) -> Y is the preferred transportaion mean wrt customer X with relevance R

customerPreferredMean(customer(ahmed, aly, 1993-01-30, single, 0, student), bus, 100).
customerPreferredMean(customer(mohamed, elkasad, 1999-01-30, single, 0, student), bus, 10).

% customerPreferredAccommodation(X, Y, R) -> Y is the preferred accommodation to customer X with relevance R

customerPreferredAccommodation(customer(ahmed, aly, 1993-01-30, single, 0, student), hotel, 20).
customerPreferredAccommodation(customer(mohamed, elkasad, 1999-01-30, single, 0, student), hotel, 100).


overlapPeriod(period(YMD1 , YMD2), period(YMD1 , YMD2)).

overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020 -> 2020 , 2019 -> 2021 ||| 2019 -> 2021 , 2020 -> 2020
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	(((Year3 < Year1 , Year4 > Year2) ; (Year3 > Year1 , Year4 < Year2));
	 ((Year3 = Year1 , Year4 > Year2 , ((Year2 =\= Year3) ; (Year2 = Year3 , Month3 < Month2)));
	   (Year3 = Year1 , Year4 < Year2 , ((Year1 =\= Year4) ; (Year1 = Year4 , Month1 < Month4))));
	 ((Year3 < Year1 , Year4 = Year2 , ((Month1 < Month4) ; (Month1 = Month4 , Day1 =< Day4))) ; (Year3 > Year1 , Year4 = Year2 , ((Month3 < Month2) ; (Month3 = Month2 , Day3 =< Day2))))). 
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4 -> 2020-6 , 2019-4 -> 2020-5 ||| 2019-4 -> 2020-5 , 2020-4 -> 2020-6
													   %2020-4-9 -> 2020-6-13 , 2019-4-9 -> 2020-4-9 ||| 2019-4-9 -> 2020-4-9 , 2020-4-9 -> 2020-6-13
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	((Year3 < Year1 , Year4 = Year2 , ((Month4 > Month1) ; (Month4 = Month1 , Day4 >= Day1))); 
	 (Year3 > Year1 , Year4 = Year2 , ((Month2 > Month3) ; (Month4 = Month1 , Day2 >= Day3)))).

overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4 -> 2020-6 , 2020-5 -> 2021-4 ||| 2020-5 -> 2021-4 , 2020-4 -> 2020-6
													   %2020-4-9 -> 2020-6-13 , 2020-6-13 -> 2021-4-9 ||| 2020-6-13 -> 2021-4-9 , 2020-4-9 -> 2020-6-13
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	((Year3 = Year1 , Year4 > Year2 , ((Month3 > Month1 , Month3 < Month2) ; (Month3 = Month1 , Month3 < Month2) ; (Month3 = Month2 , Day3 =< Day2)));
	 (Year3 = Year1 , Year4 < Year2 , ((Month3 < Month1 , Month1 < Month4) ; (Month3 = Month1 , Month1 < Month4) ; (Month1 = Month4 , Day1 =< Day4)))).
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4-9 -> 2020-6-13 , 2020-3-9 -> 2020-7-13 ||| 2020-3-9 -> 2020-7-13 , 2020-4-9 -> 2020-6-13
													   %2020-4-9 -> 2021-2-13 , 2020-3-9 -> 2021-1-13 ||| 2020-3-9 -> 2021-1-13 , 2020-4-9 -> 2021-2-13
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4)),
	(Year3 = Year1 , Year4 = Year2 ,((Month3 < Month1 , Month4 > Month2) ; (Month3 > Month1 , Month4 < Month2))).
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4-9 -> 2020-6-13 , 2020-(3/4)-9 -> 2020-5-13 ||| 2020-3-9 -> 2020-5-13 , 2020-4-9 -> 2020-6-13
													   %2020-4-9 -> 2021-1-13 , 2020-(3/4)-9 -> 2021-2-13 ||| 2020-3-9 -> 2021-2-13 , 2020-4-9 -> 2021-1-13
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	(Year3 = Year1 , Year4 = Year2 ,((Month3 =< Month1 , Month4 < Month2 , Month4 >= Month1 , (Day4 >= Day1)) ; (Month3 >= Month1 , Month4 > Month2 , Month2 >= Month3 , (Day2 >= Day3)))).
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4-9 -> 2020-6-13 , 2020-5-9 -> 2020-7-13 ||| 2020-5-9 -> 2020-7-13 , 2020-4-9 -> 2020-6-13
													   %2020-4-9 -> 2021-1-13 , 2020-5-9 -> 2021-2-13 ||| 2020-5-9 -> 2021-2-13 , 2020-4-9 -> 2021-1-13
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4)),
	(Year3 = Year1 , Year4 = Year2 ,((Year1 = Year2 , ((Month3 > Month1 , Month3 < Month2 , Month4 > Month2) ; (Month3 < Month1 , Month1 < Month4 , Month4 < Month2))); 
									 (Year1 < Year2 , ((Month3 > Month1 , Month4 > Month2) ; (Month3 < Month1 , Month4 < Month2))))).


overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-6-13 -> 2020-6-25 , 2020-6-12 -> 2020-6-26 ||| 2020-6-12 -> 2020-6-26 , 2020-6-13 -> 2020-6-25
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	(Year3 = Year1 , Year4 = Year2 , Month3 = Month1 , Month4 = Month2 ,((Day3 < Day1 , Day4 > Day2) ; (Day3 > Day1 , Day4 < Day2))).
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-6-13 -> 2020-6-25 , 2020-6-(12/13) -> 2020-6-20 ||| 2020-6-12 -> 2020-6-20 , 2020-6-13 -> 2020-6-25
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	(Year3 = Year1 , Year4 = Year2 , Month3 = Month1 , Month4 = Month2 ,((Day3 =< Day1 , Day4 =< Day2) ; (Day3 >= Day1 , Day4 >= Day2))).
	
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-6-13 -> 2020-6-25 , 2020-6-15 -> 2020-6-(30/25) ||| 2020-6-15 -> 2020-6-(30/25) , 2020-6-13 -> 2020-6-25
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)),
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	(Year3 = Year1 , Year4 = Year2 , Month3 = Month1 , Month4 = Month2 ,((Day3 >= Day1 , Day4 >= Day2) ; (Day3 =< Day1 , Day4 =< Day2))).


toString(YMD , S) :-
	with_output_to(atom(A), write(YMD)),
	split_string(A, "-" , "\s", S).

parseInteger([],[]).
parseInteger([Head|Tail],[Head1|Tail1]):-
	number_string(Head1,Head),
	parseInteger(Tail,Tail1).

	