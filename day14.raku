my $fh = open "day14.in";

# input string
my $input = $fh.get;

#blank line
$fh.get;

#rules
my %rules;
while my $line = $fh.get {
    my ($pair, $insert) = $line.split(" -> ");
    $insert = $pair.substr(0,1) ~ ";" ~ $insert ~ ";" ~ $pair.substr(1,1);
    %rules{$pair} = $insert;
}
$fh.close;

for 1..40 {
    for %rules.keys -> $key {
        my $old = "";
        while $old ne $input {
            $old = $input;
            $input = $input.subst($key, %rules{$key}, :g);
        }
    }
    $input = $input.subst(";", "", :g);
}
#say $input.chars;
say "boo";

my %count;
for 0..($input.chars - 1) {
    my $c = $input.substr($_, 1);
    %count{$c} = (%count{$c} // 0) + 1; 
}
#say %count.maxpairs;
#say %count.minpairs;
#my $x = %count.maxpairs.first.value - %count.minpairs.first.value;
#say $x;
