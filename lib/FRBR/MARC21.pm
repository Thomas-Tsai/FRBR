package FRBR::MARC21;

=head1 NAME 

FRBR::MARC21 - convert marc21 to FRBR

=head1 DESCRIPTION

auto convert marc21 to FRBR

=cut

use strict;
use warnings;
use base qw( Exporter );

our @EXPORT = qw( %Entry_Attrs_to_marc21 get_work_attrs_to_marc21 get_attrs_to_marc21);

=head2 get_work_attrs_to_marc21

return convert table for work

=cut

sub get_work_attrs_to_marc21 {
    my %Work_Attrs_to_marc21;
    %Work_Attrs_to_marc21 = (
	'title_work'			      => [ qw(100$n 100$p 100$t 110$t 110$p 110$n 111$t 111$n 111$p 130$t 130$p 130$n 240$p 240$n 243$p 243$n 600$t 600$n 600$p 610$p 610$t 610$n 611$t 611$n 611$p 630$n 630$p 630$t 700$t 700$p 700$n 710$n 710$t 710$p 711$t 711$p 711$n 730$t 730$p 730$n 800$t 800$p 800$n 810$n 810$p 810$t 811$p 811$n 811$t 830$n 830$p 830$t) ],
	'form_work'			      => [ qw(047$a 100$k 110$k 111$k 130$k 240$k 243$k 245$k 504$a 600$v 600$k 610$k 610$v 611$k 611$v 630$k 630$v 648$v 650$v 651$v 654$v 655$v 656$v 656$k 657$v 700$k 710$k 711$k 730$k 800$k 810$k 811$k 830$k) ],
	'date_work'			      => [ qw( 100$f 110$f 111$f 130$f 130$d 240$d 240$f 243$d 243$f 245$g 245$f 600$f 610$f 611$f 630$f 630$d 700$f 710$f 711$f 730$d 730$f 800$f 810$f 811$f 830$d 830$f) ],
	'other_distinguishing_characteristic' => [ qw(130$s 240$s 243$s 600$s 610$s 611$s 630$s 700$s 710$s 711$s 730$s 800$s 810$s 811$s 830$s ) ],
	'intended_termination'		      => [ qw(521$a) ],
#	'intended_audience'		      => [ qw() ],
#	'context_work'			      => [ qw() ],
	'medium_performance_musical_work'     => [ qw(130$m 240$m 243$m 700$m 710$m 730$m) ],
#	'numeric_designation_musical_work'    => [ qw() ],
	'key_musical_work'		      => [ qw(130$r 240$r 243$r 600$r 610$r 630$r 700$r 710$r 730$r 800$r 810$r 830$r) ],
	'coordinates_cartographic_work'	      => [ qw(255$c) ],
#	'equinox_cartographic_work'	      => [ qw() ],
    );
    return %Work_Attrs_to_marc21;
}
sub get_expression_attrs_to_marc21{
    my %Expression_Attrs_to_marc21;
    %Expression_Attrs_to_marc21 = (
#	    'title_expression'                    => [ qw() ],
#            'form_expression'                     => [ qw() ],
#	    'date_expression'                     => [ qw() ],
            'language_expression'                 => [ qw(041$g 041$h 041$f 041$e 041$b 041$d 041$a 100$l 110$l 111$l 130$l 240$l 243$l 546$a 600$l 610$l 611$l 630$l 700$l 710$l 711$l 800$l 810$l 811$l 830$l) ],
            'other_distinguishing_characteristic' => [ qw(562$c 130$o 240$o 243$o 245$s 600$o 610$o 630$o 700$o 710$o 730$o 800$o 810$o 830$o) ],
            'extent_expression'                   => [ qw(256$a 306$a) ],
#	    'revisability_expression'             =>
            'summarization_content'               => [ qw(505$a 505$g 505$r 505$t 520$a) ],
#	    'context_expression'                  =>
	    'critical_response_to_expression'     => [ qw(586$a) ],
#	    'use_restrictions_expression'         => 
#	    'sequencing_pattern'                  =>
            'expected_regularity_issue'           => [ qw(533$7 843$7 853$n 853$y 854$n 854$y 855$n 855$y) ],
            'expected_frequency_issue'            => [ qw(310$a 321$a 533$7 843$7 853$w 854$w 855$w) ],
	    'type_score'                          => [ qw(254$a) ],
#	    'medium_performance'                  =>
            'scale'                               => [ qw(034$h 034$c 034$b 255$a), qw(507$a 507$b) ],
	    'projection'                          => [ qw(255$b) ],
#            'geodetic_grid_vertical_measurement'  => [ qw() ],
#            'recording_technique'                 => [ qw() ],
            'special_characteristic'              => [ qw(342$o 514$m) ],
#            'technique'                           => [ qw() ],
    );
     return %Expression_Attrs_to_marc21;
}


sub get_manifestation_attrs_to_marc21{
    my %Manifestation_Attrs_to_marc21;
    %Manifestation_Attrs_to_marc21 = (
            'title_manifestation'                     => [ qw(031$g 031$c 031$b 031$a 242$a 242$n 242$p 245$n 245$p 245$a 246$a 246$p 246$n 247$a 247$n 247$p), qw(
	    210$a 222$a 524$a 534$k 544$d 547$a 773$p 786$p 844$a 852$l 856$f), qw(534$t 760$t 762$t 765$t 767$t 770$t 772$t 773$t 774$t 775$t 776$t 777$t 780$t 785$t 786$t 787$t) ],
            'statement_responsibility'                => [ qw(242$c 245$c 508$a 511$a 550$a) ],
            'edition_issue_designation'               => [ qw(037$g 250$a 250$b 534$b 760$b 762$b 765$b 767$b 770$b 772$b 773$b 774$b 775$b 776$b 777$b 780$b 785$b 786$b 787$b) ],
            'place_publication_distribution'          => [ qw(260$a 260$e), qw(257$a 533$b 843$b), qw(534$c 760$d 762$d 765$d 767$d 770$d 772$d 773$d 774$d 775$d 776$d 777$d 780$d 785$d 786$d 787$d), qw(013$b 044$a 044$b 044$c)],
            'publisher_distributor'                   => [ qw(260$b) ],
            'date_publication_distribution'           => [ qw(260$c 260$g), qw(046$n 046$j 046$b 046$c 046$m 046$l 046$d 046$e 046$k), qw(533$d 843$d) ],
            'fabricator_manufacturer'                 => [ qw(260$f) ],
            'series_statement'                        => [ qw(490$a 490$x 490$v 533$f 534$f 765$k 767$k 770$k 772$k 773$k 774$k 775$k 776$k 777$k 780$k 785$k 786$k 787$k 843$f) ],
            'form_carrier'                            => [ qw(037$f 130$h 240$h 243$h 600$h 610$h 611$h 630$h 700$h 710$h 711$h 730$h 740$h 800$h 810$h 811$h 830$h 842$a), qw(242$h 245$h 246$h 247$h) ],
            'extent_carrier'                          => [ qw(300$a) ],
            'physical_medium'                         => [ qw(340$e 340$c 340$a) ],
            'capture_mode'                            => [ qw(340$d) ],
            'dimensions_carrier'                      => [ qw(300$c 340$b) ],
            'manifestation_identifier'                => [ qw(013$a 018$a 020$a 020$z 022$a 022$y 022$z 024$a 024$z 027$z 027$a 028$a 030$z 030$a 031$u 036$a 037$a 074$z 074$a 086$a 086$z 088$a 088$z 247$x 505$u 506$u 510$x 514$u 520$u 530$u 530$d 534$z 534$x 538$u 540$u 545$u 552$u 555$u 556$z 563$u 581$z 583$u 700$x 710$x 711$x 730$x 760$o 760$x 760$y 762$o 762$x 762$y 765$u 765$y 765$x 765$r 765$o 765$z 767$r 767$u 767$x 767$y 767$z 767$o 770$o 770$r 770$u 770$x 770$z 770$y 772$z 772$x 772$y 772$o 772$r 772$u 773$o 773$r 773$u 773$x 773$y 773$z 774$y 774$u 774$r 774$z 774$x 774$o 775$x 775$y 775$u 775$r 775$o 775$z 776$o 776$z 776$y 776$x 776$r 776$u 777$y 777$o 777$x 780$y 780$r 780$u 780$x 780$z 780$o 785$x 785$z 785$u 785$y 785$o 785$r 786$z 786$x 786$y 786$r 786$o 786$u 787$r 787$o 787$u 787$x 787$y 787$z 852$s 856$u) ],
            'source_acquisition_access_authorization' => [ qw(031$z 031$s 270$d 270$b 270$c 270$e 270$a 270$z 270$m 530$b 555$b 856$n 856$a 856$b) ],
            'terms_availability'                      => [ qw(020$c 024$c 037$c 530$c) ],
            'access_restrictions_manifestation'       => [ qw(856$m 856$l 856$k 856$t 856$i 856$j 856$o 856$r 856$p) ],
#	    'typeface'                                =>
#	    'type_size'                               =>
#	    'foliation'                               =>
#	    'collation'                               =>
#	    'publication_status'                      =>
            'numbering'                               => [ qw(362$a 515$a 533$m 800$v 810$v 811$v 830$v 843$m 853$m 853$l 853$k 853$j 853$i 853$h 853$g 853$d 853$c 853$b 853$a 853$f 853$e 854$h 854$m 854$l 854$k 854$i 854$g 854$f 854$e 854$d 854$c 854$b 854$j 854$a 855$l 855$e 855$k 855$j 855$i 855$h 855$f 855$m 855$d 855$c 855$b 855$a 855$g 863$b 863$h 863$g 863$f 863$e 863$c 863$a 863$d 863$i 863$m 863$l 863$k 863$j 864$l 864$j 864$f 864$e 864$d 864$c 864$b 864$a 864$i 864$m 864$k 864$h 864$g 865$m 865$a 865$b 865$c 865$d 865$e 865$l 865$j 865$i 865$f 865$k 865$g 865$h) ],
            'playing_speed'                           => [ qw(340$f) ],
#	    'groove_width'                            => [ qw() ],
#           'kind_cutting'                            => [ qw() ],
#            'tape_configuration'                      => [ qw() ],
#            'kind_sound'                              => [ qw() ],
#            'special_reproduction_characteristic'     => [ qw() ],
#            'colour'                                  => [ qw() ],
            'reduction_ratio'                         => [ qw(340$f) ],
#            'polarity'                                => [ qw() ],
#            'generation'                              => [ qw() ],
#	    'presentation_format'                     => [ qw() ],
            'system_requirements'                     => [ qw(753$a 753$b 753$c), qw(340$I), qw(538$a) ],
            'file_characteristics'                    => [ qw(856$q 856$c), qw(546$b) ],
            'mode_access'                             => [ qw(856$2) ],
            'access_address'                          => [ qw(856$m 856$l 856$k 856$t 856$i 856$j 856$o 856$r 856$p) ],
            );

    return %Manifestation_Attrs_to_marc21;
}

sub get_item_attrs_to_marc21{
    my %Item_Attrs_to_marc21;
    %Item_Attrs_to_marc21 = (
            'item_identifier'          => [ qw(050$b 050$a 051$b 051$a 055$b 055$a 060$b 060$a 061$b 061$a 070$b 070$a 071$a 071$b 080$b 082$b 084$a 084$b 490$l 541$e 562$b 852$m 852$j 852$i 852$h 852$c 852$k 852$p 852$t 853$t 854$t 855$t 863$t 864$t 865$t 876$p 876$r 876$t 876$b 876$a 877$a 877$b 877$p 877$r 877$t 878$t 878$p 878$b 878$r 878$a) ],
#            'fingerprint'              => [ qw() ],
            'provenance_item'          => [ qw(876$e 877$e) ],
            'marks_inscription'        => [ qw(026$e 026$a 026$b 563$a 562$a) ],
            'condition_item'           => [ qw(852$q) ],
            'treatment_history'        => [ qw(583$z 583$x) ],
#	    'scheduled_treatment'      => [ qw() ],
	    'access_restrictions_item' => [ qw(876$h 877$h) ],
            );
    return %Item_Attrs_to_marc21;
}

sub get_person_attrs_to_marc21{
    my %Person_Attrs_to_marc21;
    %Person_Attrs_to_marc21 = (
            'name'              => [ qw(100$q 100$j 100$a 600$q 600$a 600$j 700$q 700$a 700$j 800$q 800$a 800$j) ],
            'dates'             => [ qw(100$d 600$d 700$d 800$d) ],
            'title'             => [ qw(100$c 700$c 800$c) ],
            'other designation' => [ qw(100$b 600$b 700$b 800$b) ],
        );

    return %Person_Attrs_to_marc21;
}

sub get_corporate_body_attrs_to_marc21{
    my %Corporate_Body_Attrs_to_marc21;
    %Corporate_Body_Attrs_to_marc21 = (
            'name'		=> [ qw(110$b 111$q 111$e 610$b 611$q 611$e 710$b 711$e 810$b 811$e), qw(535$a 544$a 711$q 811$q), qw(110$a 111$a 610$a 611$a 710$a 711$a 810$a 811$a) ],
#            'number'            => [ qw() ],
            'place'             => [ qw(110$c 111$c), qw(610$c 611$c 710$c 711$c 810$c 811$c) ],
            'date'              => [ qw(111$d), qw(611$d 711$d 811$d) ],
#            'other designation' => [ qw() ],
    );

    return %Corporate_Body_Attrs_to_marc21;
}

sub get_concept_attrs_to_marc21{
    my %Concept_Attrs_to_marc21;
    %Concept_Attrs_to_marc21 = (
             'term' => [ qw(600$x 610$x 611$x 630$x 648$x 650$x 651$x 655$a 655$x 656$a 656$x 657$x 657$a 754$a 754$d 754$c), qw(072$a 072$x 650$b 650$a 653$a 654$a 654$b 655$b) ],
    );
    return %Concept_Attrs_to_marc21;
}

sub get_object_attrs_to_marc21{
    my %Object_Attrs_to_marc21;
    %Object_Attrs_to_marc21 = (
            'term' => [ qw(072$a 072$x 650$b 650$a 653$a 654$a 654$b 655$b) ],
    );

    return %Object_Attrs_to_marc21;
}

sub get_event_attrs_to_marc21{
    my %Event_Attrs_to_marc21;
    %Event_Attrs_to_marc21 = (
            'term' => [ qw(045$a 045$b 045$c 513$b 600$y 610$y 611$y 630$y 648$a 648$y 650$y 650$d 651$y 654$y 655$y 656$y 657$y 786$j), qw(072$a 072$x 650$b 650$a 653$a 654$a 654$b 655$b) ],
    );

    return %Event_Attrs_to_marc21;
}

sub get_place_attrs_to_marc21{
    my %Place_Attrs_to_marc21;
    %Place_Attrs_to_marc21 = (
            'term' => [ qw(043$b 043$c 043$a 052$d 052$a 052$b 522$a 600$z 610$z 611$z 630$z 648$z 650$c 650$z 651$z 651$a 654$z 655$z 656$z 657$z 662$f 662$a 662$g 662$h 662$d 662$c 662$b 752$c 752$b 752$a 752$g 752$f 752$d 752$h), qw(072$a 072$x 650$b 650$a 653$a 654$a 654$b 655$b) ],
    );
    return %Place_Attrs_to_marc21;
}

my %Entry_Attrs_to_marc21 = (
    'work'           => \&get_work_attrs_to_marc21,
    'expression'     => \&get_expression_attrs_to_marc21,
    'manifestation'  => \&get_manifestation_attrs_to_marc21,
    'item'           => \&get_item_attrs_to_marc21,
    'person'         => \&get_person_attrs_to_marc21,
    'corporate_body' => \&get_corporate_body_attrs_to_marc21,
    'concept'        => \&get_concept_attrs_to_marc21,
    'object'         => \&get_object_attrs_to_marc21,
    'event'          => \&get_event_attrs_to_marc21,
    'place'          => \&get_place_attrs_to_marc21
);

sub get_attrs_to_marc21 {
    my $entry = $_[0];
    return &{$Entry_Attrs_to_marc21{$entry}};
}


1;
