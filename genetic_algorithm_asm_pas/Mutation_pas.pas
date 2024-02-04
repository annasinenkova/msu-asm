unit Mutation_pas;

interface

uses Read_par;

function Swap_bit(gene: longword; i, j: integer): longword;
function Changing_bit(gene: longword): longword;
function Transposition_bits(gene: longword): longword;
function Reverse(gene: longword): longword;

implementation
function Swap_bit(gene: longword; i, j: integer): longword;
begin
    if ((gene and (1 shl j)) shr j <> (gene and (1 shl i)) shr i) then
        Swap_bit := gene xor ((1 shl i) or (1 shl j));
end;


function Changing_bit(gene: longword): longword;
begin
    Changing_bit := gene xor (1 shl random(31));
end;


function Transposition_bits(gene: longword): longword;
begin
    Transposition_bits := Swap_bit(gene, random(31), random(31));
end;


function Reverse(gene: longword): longword;
var
    i, j: integer;
begin
    i := random(31);
    for j := 0 to ((i + 1) div 2) do
        gene := Swap_bit(gene, j, i - j);
    Reverse := gene;
end;
end.
