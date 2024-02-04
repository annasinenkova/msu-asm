unit Read_par;

interface
type 
    indiv = record
        gene: longword;
        val, fit: real;
    end;


procedure Read_parameters(file_name: string);
procedure First_population;
procedure Add_ent(gene: longword; var ind: indiv);
function F(x: real): real;

var 
    pop: array of indiv;
    init_volume, max_iters, max_valueless_iters, pres_high, pres_low, cross_size, mutation_size, iter, valueless_iter: integer;
    quality_eps, enough_func_value, best_prev: real;
    selection_method, cross_method, mutation_method: string;
    mode, screen, flag: boolean;

implementation
function F(x: real): real;
begin
    F := (x - 2)*(x - 0.5)*(x - 0.25)*(x - 1.5)*sin(x/5);
end;

procedure Add_ent(gene: longword; var ind: indiv);
begin
    ind.gene := gene;
    ind.val := ind.gene * 4 / exp(32*ln(2));
    ind.fit := F(ind.val);
end;

procedure First_population;
var
    i: integer;
begin
    SetLength(pop, init_volume);
    for i := 0 to High(pop) do
        Add_ent(random(maxlongint*2 + 1), pop[i]);
end;


procedure Read_parameters(file_name: string);
var
    str, a, b: string;
    pos_z: integer;
    f: text;
begin
    assign(f, file_name);
    reset(f);
    init_volume := 30;
    max_iters := 500;
    max_valueless_iters := 100;
    quality_eps := 0.00001;
    enough_func_value := 1.411962;
    pres_high := 3;
    pres_low := 3;
    cross_size := 5;
    mutation_size := 10;
    selection_method := 'proportional';
    cross_method := 'single';
    mutation_method := 'changing';
    mode := true;
    screen := false;
    while not eof(f) do begin
        readln(f, str);
        pos_z := pos('=', str);
        if (pos_z <> 0) and (str[1] <> '#') then begin
            a := copy(str, 0, pos_z - 1);
            b := copy(str, pos_z + 1, High(str));
            if (a = 'init_volume') then
                val(b, init_volume)
            else if (a = 'max_iters') then
                val(b, max_iters)
            else if (a = 'max_valueless_iters') then
                val(b, max_valueless_iters)
            else if (a = 'quality_eps') then
                val(b, quality_eps)
            else if (a = 'enough_func_value') then
                val(b, enough_func_value)
	    else if (a = 'mutation_size') then
                val(b, mutation_size)
            else if (a = 'selection_method') then
                selection_method := b
            else if (a = 'cros_method') then
                cross_method := b
            else if (a = 'mutaion_method') then
                mutation_method := b
            else if (a = 'pres_high') then
                val(b, pres_high)
            else if (a = 'pres_low') then
                val(b, pres_low)
            else if (a = 'cross_size') then
                val(b, cross_size)
            else if (a = 'mode') then
                mode := (b = 'non-test')
            else if (a = 'screen') then
                screen := (b = 'yes');
        end;
    end;
    close(f);
end;
end.
