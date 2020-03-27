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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



possibleSubset([],[]).
possibleSubset([H|T],[H]).
possibleSubset([H|T],R) :- permutation([H|T], R).
possibleSubset([H|T],R) :- possibleSubset(T, R).

    