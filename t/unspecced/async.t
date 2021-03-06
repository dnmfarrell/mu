use v6;

use Test;

=begin kwid

= DESCRIPTION

This test tests the interaction of C<async {}> and
C<run>. Ideally, while a C<run> call is in progress,
C<async> blocks are still being executed.

=end kwid

plan 1;
diag "Running under $*OS";

my @events;
my $event_count = 4;

sub spawn_counter () {
  async {
    my $count = $event_count;
    while ($count--) {
      diag $count;
      push @events, time();
      sleep 1; # five seconds are enough for everybody
    };
  };
};

my $redir = ">";

ok(0, "async+run known to be erratic _everywhere_, disable for now", :todo<bug>);
exit;

if $?OS eq any <MSWin32 mingw msys cygwin> {
  skip 1, "async known to be problematic on Win32";
  exit;
};

diag "Spawning counter";
spawn_counter();
run( qq!$*EXECUTABLE_NAME -e "sleep(5)"!); 

if (!ok(@events == $event_count, "Our async counter finished while we were running a subprocess")) {
  diag "Got      " ~ +@events ~ " element(s).";
  diag "Expected $event_count elements."
};
