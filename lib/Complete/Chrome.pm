package Complete::Chrome;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = qw(
                       complete_chrome_profile_name
               );

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Completion routines related to Google Chrome',
};

$SPEC{complete_chrome_profile_name} = {
    v => 1.1,
    args => {
        word => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
    },
    result_naked => 1,
};
sub complete_chrome_profile_name {
    require Complete::Util;
    require Chrome::Util::Profile;

    my %args = @_;

    my $res = Chrome::Util::Profile::list_chrome_profiles(detail=>1);
    return {message=>"Can't list Chrome profiles: $res->[0] - $res->[1]"}
        unless $res->[0] == 200;

    Complete::Util::complete_array_elem(
        word  => $args{word},
        array => [map {$_->{name}} @{ $res->[2] }],
    );
}

1;
# ABSTRACT:

=for Pod::Coverage .+

=head1 SEE ALSO

L<Complete>

Other C<Complete::*> modules.
