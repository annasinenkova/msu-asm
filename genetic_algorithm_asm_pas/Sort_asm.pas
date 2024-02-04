unit Sort_asm;


interface

uses Read_par;

{$L ./sort.obj}
procedure Sort(var g: longword; N: longword); pascal; external name 'S';

implementation
begin
end.
