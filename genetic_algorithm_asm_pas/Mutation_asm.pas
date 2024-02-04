unit Mutation_asm;

interface

{$L ./mutation.obj}
function Changing_bit(gene: longword): longword; pascal; external name 'Changing_bit';
function Transposition_bits(gene: longword): longword; pascal; external name 'Transposition_bits';
function Reverse(gene: longword): longword; pascal; external name 'Reverse';


implementation
begin
end.