/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).
prefix([], _).
prefix([X|Xs], [X|Ys]) :- prefix(Xs, Ys).
sub_list(Sublist, List) :- prefix(Sublist, List).
sub_list(Sublist, [_|Tail]) :- sub_list(Sublist, Tail).


% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.   
append([], L, L).
append([X | L1], L2, [X | L3]) :- 
    append(L1, L2, L3).

swap_list([], []).

swap_list([X | Xs], InversedList) :-
    swap_list(X, ReversedHead),
    !, 
    swap_list(Xs, ReversedTail),
    append(ReversedTail, [ReversedHead], InversedList).

swap_list([X | Xs], InversedList) :-
    swap_list(Xs, ReversedTail),
    append(ReversedTail, [X], InversedList).


% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.
sub_tree(tree(X, void, void), tree(X, void, void)).
sub_tree(X, tree(_Y, Left, _Right)) :- sub_tree(X, Left).
sub_tree(X, tree(_Y, _Left, Right)) :- sub_tree(X, Right).
sub_tree(tree(Y, Left1, Right1), tree(Y, Left2, Right2)) :- 
    sub_tree(Left1, Left2), 
    sub_tree(Right1, Right2).




% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the �mirror� representation of Tree.
swap_tree(void, void).
swap_tree(tree(X, Left1, Right1), tree(X, Right2, Left2)):-swap_tree(Left1, Left2), swap_tree(Right1, Right2).