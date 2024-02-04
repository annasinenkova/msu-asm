unit Selection_pop;

interface

uses Read_par;

procedure Truncation_selection(pres_low: integer);
procedure Swap_ent(i, j: integer);
procedure Roulette_selection(pres_high, pres_low: integer);
procedure Selection;


implementation
procedure Truncation_selection(pres_low: integer);
var
    j, i: integer;
begin
    j := round(0.6 * (High(pop) + 1));
    for i := 1 to pres_low do
        pop[j - i] := pop[High(pop) - i + 1];
    Setlength(pop, j);
end;


procedure Swap_ent(i, j: integer);
var
    s: indiv;
begin
    s := pop[i];
    pop[i] := pop[j];
    pop[j] := s;
end;


procedure Roulette_selection(pres_high, pres_low: integer);
var
    i, k: integer;
    sum: real = 0.0;
    test_value: real;
begin
    for i := 0 to pres_low - 1 do
        Swap_ent(pres_high + i, High(pop) - i);
    for i := 0 to High(pop) do
        sum := sum + pop[i].fit;
    k := pres_high + pres_low;
    for i := pres_high + pres_low to High(pop) do begin
        test_value := random;
        if (test_value < pop[i].fit/sum) then begin
            if (i <> k) then
                Swap_ent(i, k);
            k := k + 1;
        end;
    end;
    Setlength(pop, k);
end;


procedure Selection;
begin
    if (selection_method = 'truncation') then
        Truncation_selection(pres_low)
    else if (selection_method = 'roulette') then
        Roulette_selection(pres_high, pres_low);
end;
end.
