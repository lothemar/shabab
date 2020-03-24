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
	
%overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4-9 -> 2020-6-13 , 2019-4-9 -> 2020-4-9 ||| 2019-4-9 -> 2020-4-9 , 2020-4-9 -> 2020-6-13
%	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
%	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
%	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
%	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
%	((Year3 < Year1 , Year4 = Year2 , Month4 = Month1 , Day4 >= Day1) ; (Year3 > Year1 , Year4 = Year2 , Month2 = Month3 , Day2 >= Day3)).

%overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020-4-9 -> 2020-6-13 , 2020-6-13 -> 2021-4-9 ||| 2020-6-13 -> 2021-4-9 , 2020-4-9 -> 2020-6-13
%	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
%	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
%	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
%	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
%	((Year3 = Year1 , Year4 > Year2 , Month3 = Month2 , Day3 =< Day2) ; (Year3 = Year1 , Year4 < Year2 , Month1 = Month4 , Day1 =< Day4)).
	
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








%overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-
%	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
%	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
%	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
%	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
%	((Year3 >= Year1, Year4 < Year2);(Year3 < Year1 , Year4 > Year2);
%	(Year3 =< Year1 , Year4 >= Year2, Month3 =< Month1);
%	(Year3 >= Year1, Year3 =< Year2, Year4 >= Year2, Month3 =< Month2);
%	(Year4 >= Year1, Year4 =< Year2, Year3 =< Year1, Month4 >= Month1)),
%	((Year3 >= Year1, Year4 < Year2);(Year3 < Year1 , Year4 > Year2);
%	(Year3 =< Year1 , Year4 >= Year2, Month3 =< Month1);
%	(Month3 >= Month1, Month4 < Month2);(Month3 < Month1 , Month4 >= Month2);
%	(Month3 >= Month1, Month3 =< Month2, Month4 > Month2, Day3 =< Day2);
%	(Month4 >= Month1, Month4 =< Month2, Month3 < Month1, Day4 >= Day1)).


%overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-
%	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
%	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
%	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
%	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
%	((Year3 =< Year1, Year4 > Year2);(Year3 > Year1 , Year4 < Year2);
%	(Year3 =< Year1, Year3 >= Year2, Year4 =< Year2, Month3 >= Month2);
%	(Year4 =< Year1, Year4 >= Year2, Year3 >= Year1, Month4 =< Month1)),
%	((Year3 =< Year1, Year4 > Year2);(Year3 > Year1 , Year4 > Year2);
%	(Month3 =< Month1, Month4 < Month2);(Month3 > Month1 , Month4 =< Month2);
%	(Month3 =< Month1, Month3 >= Month2, Month4 < Month2, Day3 >= Day2);
%	(Month4 =< Month1, Month4 >= Month2, Month3 > Month1, Day4 =< Day1)).



toString(YMD , S) :-
	with_output_to(atom(A), write(YMD)),
	split_string(A, "-" , "\s", S).

parseInteger([],[]).
parseInteger([Head|Tail],[Head1|Tail1]):-
	number_string(Head1,Head),
	parseInteger(Tail,Tail1).

prefExists(H, [H|T]).
prefExists(H, [H1|T]):-
    prefExists(H, T).
meanPreference(Offer, Customer, ChosenPrefs, S):-
    offerMean(Offer, M),
    customerPreferredMean(Customer, M, R),
    prefExists(mean(M), ChosenPrefs),
    S is R, !.
meanPreference(Offer, Customer, ChosenPrefs, S):-
    offerMean(Offer, M),
    customerPreferredMean(Customer, M2, R),
    M2 \= M,
    S is 0, !.
meanPreference(Offer, Customer, ChosenPrefs, S):-
    offerMean(Offer, M),
    customerPreferredMean(Customer, M, R),
    S is 0, !.


accomodationPreference(Offer, Customer, ChosenPrefs, S):-
    offerAccommodation(Offer, M),
    customerPreferredAccommodation(Customer, M, R),
    prefExists(accommodation(M), ChosenPrefs),
    S is R, !.
accomodationPreference(Offer, Customer, ChosenPrefs, S):-
    offerAccommodation(Offer, M),
    customerPreferredAccommodation(Customer, M2, R),
    M2 \= M,
    S is 0, !.
accomodationPreference(Offer, Customer, ChosenPrefs, S):-
    offerAccommodation(Offer, M),
    customerPreferredAccommodation(Customer, M, R),
    S is 0, !.


extractActivities([], []).
extractActivities([activity([H|T])|T1], [H|T]).
extractActivities([H|T], PrefActivities):-
    extractActivities(T, PrefActivities).

activityContained([], Customer, H, 0).
activityContained([H|T], Customer, H, S):-
    customerPreferredActivity(Customer, H, S).
activityContained([H|T], Customer, H1, S):-
    activityContained(T, Customer, H1, S).

activitiesInPreferences(Activities, Customer, [], 0).
activitiesInPreferences(Activities, Customer, [H2|T], S):-
    activityContained(Activities, Customer, H2, S1),
    activitiesInPreferences(Activities, Customer, T, S2),
    S is S1 + S2, !.

%First we extract activities from chosen preferences then
%pass them as a list to compare them with activities in the offer
%returning the rating values we get from the Customer.
activityPreference(offer(_, Activities, _, _, _, period(_, _), _, _), Customer, ChosenPrefs, S):-
    extractActivities(ChosenPrefs, PrefActivities),
    activitiesInPreferences(Activities, Customer, PrefActivities, S).

preferenceSatisfaction(Offer, Customer, ChosenPrefs, S):-
    activityPreference(Offer, Customer, ChosenPrefs, S1),
    meanPreference(Offer, Customer, ChosenPrefs, S2),
    accomodationPreference(Offer, Customer, ChosenPrefs, S3),
    S is S1 + S2 + S3, !.