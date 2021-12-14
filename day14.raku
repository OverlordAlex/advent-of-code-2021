my $fh = open "day14.in";

# input string
my $input = $fh.get;
my %chrs;
for 0..($input.chars - 2) {
    my $pair = $input.substr($_, 2);
    %chrs{$pair} = (%chrs{$pair} // 0) + 1; 
}

#blank line
$fh.get;

#rules
my %rules;
while my $line = $fh.get {
    my ($pair, $insert) = $line.split(" -> ");
    my $first = $pair.substr(0, 1) ~ $insert;
    my $second = $insert ~ $pair.substr(1, 1);
    %rules{$pair} = ($first, $second, $insert);
}
$fh.close;

for 1..40 {
    my %newChrs;
    for %chrs -> $chr {
        my ($first, $second, $insert) = %rules{$chr.key};
        %newChrs{$first} = (%newChrs{$first} // 0) + $chr.value;
        %newChrs{$second} = (%newChrs{$second} // 0) + $chr.value;
    }
    %chrs = %newChrs;
}

my %count;
for %chrs -> $chr {
    my ($first, $second);
    $first = $chr.key.substr(0, 1);
    $second = $chr.key.substr(1, 1);

    %count{$first} = (%count{$first} // 0) + $chr.value;
    %count{$second} = (%count{$second} // 0) + $chr.value;
}
# first and last started at a disadvantage, then we really have seen 2x of everything
%count{$input.substr(0, 1)} += 1;
%count{$input.substr($input.chars - 1, 1)} += 1;
for %count -> $cnt {
    $cnt.value = $cnt.value / 2;
}

my $result = %count.maxpairs.first.value - %count.minpairs.first.value;
say $result;
