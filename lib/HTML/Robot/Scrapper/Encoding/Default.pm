package HTML::Robot::Scrapper::Encoding::Default;
use Encode::Guess qw/iso-8859-1 utf8/;
use Moo;
use Encode;
use utf8;
use Data::Printer;

=head2 DESCRIPTION

The Encoding class will read $page->content and will try to make sure you receive 

a clean utf8 content. That way you dont need to worry about encodings in your parser

because they will be always utf8.

*** by default it only guesses between iso-8859-1 and utf8

if you need something else you can extend it

=cut

sub safe_encode {
    my ( $self, $robot, $headers, $content ) = @_;
    Encode::Guess->add_suspects(qw/iso-8859-1 utf8/);
    my $decoder = Encode::Guess->guess($content);
    return decode_utf8($content) unless ref($decoder);
    my $content_utf8 = $decoder->decode($content);
    return $content_utf8;
}

1;
