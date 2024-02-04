uses
    sysutils,
    Mutation_asm,
    Crossing_asm,
    Selection_pop,
    Read_par,
    Sort_asm;

var 
    out: text;
    Duration: Cardinal;
    gene: longword = 0;
    g_1, g_2: longword;
    i, ent_f, ent_s: integer;
    ind, ind_1, ind_2: indiv;


procedure Print_bit(gene: longword);
var
    i: integer;
begin
    for i := 0 to 32 do
        write((gene shr i) and 1);
end;


procedure Print_file_bit(var out: text; gene: longword);
var
    i: integer;
begin
    for i := 0 to 32 do
        write(out, (gene shr i) and 1);
end;


procedure Print_iter(var out: text);
var
    i: integer;
begin
    if (not mode) and (screen) then begin
        writeln('iteration: ', iter);
        for i := 0 to High(pop) do begin
            write('num: ', i + 1,  ' val: ' : 10, pop[i].val : 0 : 10, ' fitness: ' : 14, pop[i].fit : 0 : 10, 'bit: ' : 14);
            Print_bit(pop[i].gene);
            writeln;
        end;
    end;
    if (mode) then
        writeln('iteration: ', iter, ' val: ': 10, pop[0].val : 0 : 10, 'fitness: ' : 14, pop[0].fit : 0 : 10);
    if (not mode) then begin
        writeln(out, 'iteration: ', iter);
        for i := 0 to High(pop) do begin
            write(out, 'num: ', i + 1 : 2, 'bit: ' : 10);
	    Print_file_bit(out, pop[i].gene);
	    write(out, ' val: ' : 10, pop[i].val : 0 : 10, ' fitness: ' : 14, pop[i].fit: 0 : 10);
            writeln(out);
        end;
    end;
end;


procedure Print_end(i: integer; var out: text);
begin
    Duration := GetTickCount64() - Duration;
    if (mode or screen) then begin
        if (i = 1) then
            writeln('Max number of iterations')
        else if (i = 2) then
            writeln('Max valueless iterations')
        else if (i = 3) then
            writeln('Enough function value');
        writeln('Best individual', pop[0].val : 15 : 10);
        writeln('Function value', pop[0].fit : 15 : 10);
    end;
    if (not mode) then begin
        if (i = 1) then
            writeln(out, 'Max number of iterations')
        else if (i = 2) then
            writeln(out, 'Max valueless iterations')
        else if (i = 3) then
            writeln(out, 'Enough function value');
        writeln(out, 'Best individual', pop[0].val : 15 : 10);
        writeln(out, 'Function value', pop[0].fit : 16 : 10);
        close(out);
    end;
end;


function Stop(iter: integer; var out: text): boolean;
begin
    Stop := true;
    if (iter > max_iters) then
        Print_end(1, out)
    else if (valueless_iter > max_valueless_iters) then
        Print_end(2, out)
    else if (pop[0].fit <= enough_func_value) then
        Print_end(3, out)
    else 
        Stop := false;
end;


procedure Sortt(var pop: array of indiv; N: longword);
var
    i, j, max: integer;
    ent: indiv;
begin
    for i := N downto 1 do begin
        max := i;
        for j := i - 1 downto 0 do 
            if (pop[j].fit > pop[max].fit) then
                max := j;
        ent := pop[i];
        pop[i] := pop[max];
        pop[max] := ent;
    end;
end;


procedure Dubli;
var
    i, j, k: integer;
begin
    i := 0;
    k := 0;
    j := 1;
    while (j <= High(pop)) do begin
        while (pop[j].gene = pop[i].gene) and (j < High(pop)) do
            j := j + 1;
        if (k <> i) then
            Swap_ent(k, i);
        k := k + 1;
        i := j;
        j := j + 1;
    end;
    SetLength(pop, k);
end;


begin
    RandSeed := 2;
    Read_parameters('t.txt');
    Duration := GetTickCount64();
    First_population;
    if (not mode) then begin
        assign(out, 'output_asm.txt');
        rewrite(out);
    end;
    iter := 1;
    valueless_iter := 1;
    best_prev := 0;
    flag := true;
    while (flag) do begin
        Sort(pop[0].gene, High(pop));
	Dubli;
        if (abs(best_prev - pop[0].fit) < quality_eps) then
            valueless_iter := valueless_iter + 1
        else
            valueless_iter := 1;
        best_prev := pop[0].fit;
        Print_iter(out);
        if (not Stop(iter, out)) then begin
            Selection;
            for i := 1 to cross_size do begin
                repeat
                    ent_f := random(High(pop) - 1);
                    ent_s := random(High(pop) - 1);
                until (ent_f <> ent_s);
                if (cross_method = 'single') then
                    Single_crossing(pop[ent_f].gene, pop[ent_s].gene, g_1, g_2)
                else if (cross_method = 'two') then
                    Two_crossing(pop[ent_f].gene, pop[ent_s].gene, g_1, g_2)
                else if (cross_method = 'universal') then
                    Universal_crossing(pop[ent_f].gene, pop[ent_s].gene, g_1, g_2)
                else if (cross_method = 'uniform') then begin
                    Uniform_crossing(pop[ent_f].gene, pop[ent_s].gene, g_1);
                    repeat
                        ent_f := random(High(pop) - 1);
                        ent_s := random(High(pop) - 1);
                    until (ent_f <> ent_s);
                    Uniform_crossing(pop[ent_f].gene, pop[ent_s].gene, g_2);
                end;
                Add_ent(g_1, ind_1);
                Add_ent(g_2, ind_2);
                SetLength(pop, High(pop) + 3);
                pop[High(pop) - 1] := ind_1;
                pop[High(pop)] := ind_2;
            end;
            for i := 0 to mutation_size do begin
                Setlength(pop, High(pop) + 2);
                if (mutation_method = 'changing') then
                    gene := Changing_bit(pop[random(High(pop) - 1)].gene)
                else if (mutation_method = 'transposition') then
                    gene := Transposition_bits(pop[random(High(pop) - 1)].gene)
                else if (mutation_method = 'reverse') then
                    gene := Reverse(pop[random(High(pop) - 1)].gene);
                Add_ent(gene, ind);
                pop[High(pop)] := ind;
            end;
        end
        else
            flag := false; 
        iter := iter + 1;
    end;
    SetLength(pop, 0);
    WriteLn('Time = ', Duration);
end.
