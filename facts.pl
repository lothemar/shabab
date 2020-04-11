
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
customerPreferredActivity(customer(ahmed, obama, 1995-01-30, single, 0, student), diving, 90).
customerPreferredActivity(customer(mo, qamal, 1997-01-30, single, 0, student), snorkeling, 100).
customerPreferredActivity(customer(hassan, aly, 1999-01-30, single, 0, student), horseRiding, 70).

% customerPreferredMean(X, Y, R) -> Y is the preferred transportaion mean wrt customer X with relevance R

customerPreferredMean(customer(ahmed, aly, 1993-01-30, single, 0, student), bus, 100).
customerPreferredMean(customer(mohamed, elkasad, 1999-01-30, single, 0, student), bus, 10).
customerPreferredMean(customer(ahmed, obama, 1995-01-30, single, 0, student), bus, 50).
customerPreferredMean(customer(mo, qamal, 1997-01-30, single, 0, student), bus, 60).
customerPreferredMean(customer(hassan, aly, 1999-01-30, single, 0, student), bus, 80).

% customerPreferredAccommodation(X, Y, R) -> Y is the preferred accommodation to customer X with relevance R

customerPreferredAccommodation(customer(ahmed, aly, 1993-01-30, single, 0, student), hotel, 20).
customerPreferredAccommodation(customer(mohamed, elkasad, 1999-01-30, single, 0, student), hotel, 100).
customerPreferredAccommodation(customer(ahmed, obama, 1995-01-30, single, 0, student), hotel,70).
customerPreferredAccommodation(customer(mo, qamal, 1997-01-30, single, 0, student), hotel, 30).
customerPreferredAccommodation(customer(hassan, aly, 1999-01-30, single, 0, student), hotel, 80).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%possiblesubset
perm([H|T],L):-
	perm(T,P),
	insert(H,P,L).
perm([],[]).

insert(X,[H|T],[H|T1]):-	
	insert(X,T,T1).
insert(X,L,[X|L]).

subset([],[]).
subset([A|B] , [A|C]):-
	subset(B,C).
subset([_|A],B):-
	subset(A,B).
possibleSubset([H|T],O):-
	subset([H|T],O1),
	perm(O1,O).
possibleSubset([],[]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ChoosePreferences
activityChecker(Prefs):- member(activity(_) , Prefs) , \+(H = activity(_)).  
choosePreferences([H|T] , ChosenPreferences) :-
    (H = activity(L),
    possibleSubset(L,O1),
    O = activity(O1),
    possibleSubset(T,O2),
    append([O], O2, ChosenPreferences)).
choosePreferences(Prefs ,  ChosenPreferences) :-
    activityChecker(Prefs),
    select(activity(_) , Prefs , Prefsnew),
    member(activity(_), Prefs),
    append([activity(temp)] , Prefsnew , Prefsupdated),
    choosePreferences(Prefsupdated , ChosenPreferences).
choosePreferences(Prefs , ChosenPreferences) :-
    \+ activityChecker(Prefs),
    possibleSubset(Prefs , ChosenPreferences).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OverlapPeriod method:
overlapPeriod(period(YMD1,YMD2), period(YMD3,YMD4)):-  %2020 -> 2020 , 2019 -> 2021 ||| 2019 -> 2021 , 2020 -> 2020
	(toString(YMD1,S1), parseInteger(S1,L1), nth0(0,L1,Year1), nth0(1,L1,Month1), nth0(2,L1,Day1)),
	(toString(YMD2,S2), parseInteger(S2,L2), nth0(0,L2,Year2), nth0(1,L2,Month2), nth0(2,L2,Day2)), 
	(toString(YMD3,S3), parseInteger(S3,L3), nth0(0,L3,Year3), nth0(1,L3,Month3), nth0(2,L3,Day3)),
	(toString(YMD4,S4), parseInteger(S4,L4), nth0(0,L4,Year4), nth0(1,L4,Month4), nth0(2,L4,Day4)),
	P1 is Year1*10000 + Month1*100 + Day1, P2 is Year2*10000 + Month2*100 + Day2,
	P3 is Year3*10000 + Month3*100 + Day3, P4 is Year4*10000 + Month4*100 + Day4, 
	((P3 >= P1, P3 =< P2) ; (P4 =< P2 , P4 >= P1) ; (P3 =< P1, P1 =< P4) ; (P4 >= P2 , P2 >= P3)).

toString(YMD , S) :-
	with_output_to(atom(A), write(YMD)),
	split_string(A, "-" , "\s", S).

parseInteger([],[]).
parseInteger([Head|Tail],[Head1|Tail1]):-
	number_string(Head1,Head),
	parseInteger(Tail,Tail1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

validate(dest(X), [X|T]).
validate(dest(X), [Y|T]):-
    validate(dest(X), T).
validate(activity([H|T]), [[H1|T1]|T2]):-
    possibleSubset([H1|T1], [H|T]).
validate(activity([H|T]), [H1|T1]):-
    validate(activity([H|T]), T1).
validate(budget(Budget), [cost(Cost)|T]):-
    Budget>=Cost, !.
validate(budget(Budget), [Cost|T]):-
    validate(budget(Budget), T).
validate(period(Start, End), [period(Start2, End2)| T]):-
    overlapPeriod(period(Start, End), period(Start2, End2)).
validate(period(Start, End), [X|T]):-
    validate(period(Start, End), T).

validateOffer([], _).
validateOffer([H|T], [H1|T1]):-
    validate(H, [H1|T1]),
    validateOffer(T, [H1|T1]).

trim(ChosenPrefs, A, M, PrefUpdated):-
    prefExists(means(M), ChosenPrefs),
    select(means(M), ChosenPrefs, PrefUpdated),
    trim(PrefUpdated, A, _, PrefUpdated), !.
trim(ChosenPrefs, A, M, PrefUpdated):-
    prefExists(accomodation(A), ChosenPrefs),
    select(accomodation(A), ChosenPrefs, PrefUpdated),
    trim(PrefUpdated, _ , M, PrefUpdated), !.
trim(ChosenPrefs, A, M, ChosenPrefs).

offer_to_list(offer(Destination, Activities, Cost, _, _, period(Start, End), _, _), [Destination, Activities, cost(Cost), period(Start, End)]).
get_guests(offer(_, _, _, _, _, period(_,_), _, N), N).
%getOffer([dest(dahab), period(2020-04-01, 2020-09-15), activity([snorkeling, diving]), budget(70000)],O).

getOffer(ChosenPrefs, Offer):-
    offerAccommodation(Offer, A),
    offerMean(Offer, M),
    trim(ChosenPrefs, A, M, PrefUpdated),
    offer_to_list(Offer,OfferList),
    validateOffer(PrefUpdated, OfferList).

recommendOfferForCustomer(Prefs, ChosenPrefs, Offer):-
    possibleSubset(Prefs, ChosenPrefs),
    getOffer(ChosenPrefs, Offer).
max(S1, S2, S2):-
    S2>S1.
max(S1, S2, S1).
max(S1, S2, Offer1, Offer2, S2, Offer2):-
    S2>S1.
max(S1, S2, Offer1, Offer2, S1, Offer1).

offersProvided([], []).
offersProvided([Pref|T], [Offer| T1]):-
    recommendOfferForCustomer(Pref, _, Offer),
    offersProvided(T, T1).

maximizeSatisfaction([], [], _, 0).
maximizeSatisfaction([Customer|T], [Preference|T1], Offer, S):-
    preferenceSatisfaction(Customer, Preference, Offer, S1),
    maximizeSatisfaction(T, T1, Offer, S2),
    max(S1, S2, S).

removeBestCustomer([Customer|T], [Preference|T1], Offer, S, Customer, Preference):-
    preferenceSatisfaction(Customer, Preference, Offer, S).
removeBestCustomer([Customer|T], [Preference|T1], Offer, S, Custom, Pref):-
    removeBestCustomer(T, T1, Offer, S, Custom, Pref).

satisfactionByOffer([], [], _, 0, _).
satisfactionByOffer(_, _, _, 0, 0).
satisfactionByOffer(Customers, Preferences, Offer, S, N):-
    maximizeSatisfaction(Customers, Preferences, Offer, S1),
    N1 is N-1,
    removeBestCustomer(Customers, Preferences, Offer, S1, Customer, Preference),
    delete(Customers, Customer, RemainingCustomers),
    delete(Preferences, Preference, RemainingPrefs),
    satisfactionByOffer(RemainingCustomers, RemainingPrefs, Offer, S2, N1),
    S is S1 + S2.

findBestOffer(Customers, Preferences, [], nil, 0).
findBestOffer(Customers, Preferences, [Offer1|T1], Offer, S):-
    get_guests(Offer, N),
    satisfactionByOffer(Customers, Preferences, Offer1, S1, N),
    findBestOffer(Customers, Preferences, T1, Offer2, S2),
    max(S1, S2, Offer1, Offer2, S, Offer).

%getCustomers([Customer|T], Offer, [Customers2| T2]):-

recommendOffer(Customers, PreferenceList, Offer, CustomersChosen):-
    offersProvided(PreferenceList, Offers),
    findBestOffer(Customers, PreferenceList, Offers, Offer, S).
%    getCustomers(Customers, Offer, CustomersChosen).
%getCustomers will return the combination of CustomersChosen that led to the best offer