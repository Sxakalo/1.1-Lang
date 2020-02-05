use warnings;
use strict;

=pod

=head1 The L<1.1 Language|https://esolangs.org/wiki/1.1>

=head2 How to run: perl main.pl <args> <source file>

Args:

=over

=item -D: Turn on Debug

Prints the state number and the buffer at each step.

=back

=head2 The first line of the file should be in format:

1|<starting buffer or <empty>>

Where:

=over

=item I<starting buffer> is the starting string to use.

=item I<<empty>> if starting buffer is blank, the starting buffer will be set by STDIN.

=back

=head2 Each additional line of the file should be in format:

<#1>|<needle>|<replacement>|<#2>|<#3>

Where:

=over

=item I<<#1>> is the state number (these must be concecutive i.e 1 is followed by 2, etc.)

=item I<<needle>> is the search string to find in the buffer.

=item I<<replacement>> is to replace <needle> if found.

=item I<<#2>> is the number of the next state to go to if the <needle> was found. 

=item I<<#3>> is the number of the next state to go to if the <needle> was not found.

=back

=cut


my $rawprog = '';
my $debug = 0;

#set debug if given flag
if ($ARGV[0] eq '-D'){$debug = 1; shift @ARGV;}

#open and read file
open(my $fh, '<', $ARGV[0]) or die "Cannot open file $ARGV[0]";
while (my $row = <$fh>){
    $rawprog = $rawprog . $row;
}
close($fh);

my @prog = split /\n/, $rawprog;


####################
## Program begin ##
#################
my $buffer = '';

#set buffer to start
my @curstate = split /\|/, $prog[0];

# if starting buffer is empty read from STDIN
if(scalar(@curstate) == 1){
    my $temp = <STDIN>;
    chomp $temp;
    $buffer = $temp;
}else{$buffer = $curstate[1];}

#set statement to after start
my $statenum = 2;
while (1){
    # Get the current State
    @curstate = split /\|/, $prog[$statenum - 1];

    # Check for Halt
    if (lc($curstate[1]) eq 'halt') {last;}
    else {
	$curstate[1] = quotemeta $curstate[1];
	if ($buffer =~ /$curstate[1]/){
	    if($debug){print "$statenum: $curstate[1] ---> $curstate[2] == ";}
	    # Replace needle with replacement string
	    $buffer =~ s/$curstate[1]/$curstate[2]/;
	    $statenum = $curstate[3];
	}
	# otherwise we didn't find needle string
	else{
	    if ($debug){print "$statenum: $curstate[1] not found. == ";}
	    $statenum = $curstate[4];
	}
    }
    #If debug is turned on, print buffer everytime
    if ($debug){print "$buffer \n";}
} # end while
print $buffer;

