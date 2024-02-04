unit Crossing_pas;


interface

uses Read_par;

procedure Single_crossing(gene_1, gene_2: longword; var  g_1, g_2: longword);
procedure Two_crossing(gene_1, gene_2: longword; var g_1, g_2: longword);
procedure Universal_crossing(gene_1, gene_2: longword; var g_1, g_2: longword);
procedure Uniform_crossing(gene_1, gene_2: longword; var g: longword);


implementation
procedure Single_crossing(gene_1, gene_2: longword; var g_1, g_2: longword);
var
    m: longword;
begin
    m := not -(1 shl random(31));
    g_1 := (gene_1 and (not m)) or (gene_2 and m);
    g_2 := (gene_2 and (not m)) or (gene_1 and m);
end;


procedure Two_crossing(gene_1, gene_2: longword; var g_1, g_2: longword);
var
    m: longword;
begin
    m := (not -(1 shl random(31))) xor (not -(1 shl random(31)));
    g_1 := (gene_1 and (not m)) or (gene_2 and m);
    g_2 := (gene_2 and (not m)) or (gene_1 and m);
end;


procedure Universal_crossing(gene_1, gene_2: longword; var g_1, g_2: longword);
var
    m: longword;
    i, bit: integer;
begin
    m := 0;
    for i := 0 to 31 do begin
        bit := random(2);
        m := (m shl 1) or bit;
    end;
    g_1 := (gene_1 and (not m)) or (gene_2 and m);
    g_2 := (gene_2 and (not m)) or (gene_1 and m);
end;


procedure Uniform_crossing(gene_1, gene_2: longword; var g: longword);
var
    m: longword;
begin
    m := random(maxlongint*2 + 1);
    g := (gene_1 and m) or (gene_2 and (not m));
end;

end.
