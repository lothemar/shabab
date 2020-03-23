
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