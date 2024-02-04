unit Crossing_asm;


interface

{$L ./crossing.obj}
procedure Single_crossing(gene_1, gene_2: longword; var  g_1, g_2: longword); pascal; external name 'Single';
procedure Two_crossing(gene_1, gene_2: longword; var g_1, g_2: longword); pascal; external name 'Two_crossing';
procedure Universal_crossing(gene_1, gene_2: longword; var g_1, g_2: longword); pascal; external name 'Universal_crossing';
procedure Uniform_crossing(gene_1, gene_2: longword; var g: longword); pascal; external name 'Uniform_crossing';

implementation
begin
end.
