package FRBR::CMARC;

=head1 NAME 

FRBR::CMARC - convert cmarc to FRBR

=head1 DESCRIPTION

auto convert cmarc to FRBR

=cut

use strict;
use warnings;
use base qw( Exporter );

our @EXPORT = qw( %Entry_Attrs_to_cmarc get_work_attrs_to_cmarc get_attrs_to_cmarc);

=head2 get_work_attrs_to_cmarc

return convert table for work

=cut

sub get_work_attrs_to_cmarc {
    my %Work_Attrs_to_cmarc;
    %Work_Attrs_to_cmarc = (
	'title_work'			      => [ qw(500$ahi 501$a 600$hit 601$hit 605$hit 700$hit 702$hit 710$hit 712$hit 
						    750$hit 752$hit 760$hit 762$hit) ],
	'form_work'			      => [ qw(105$a 110$a 115$a 120$a 215$e 500$l 501$l 600$l 601$l 605$l 606$l 
						    607$l 700$l 702$l 710$l 712$l 750$l 752$l 760$l 762$l) ],
	'date_work'			      => [ qw(500$k 501$k 600$k 601$k 605$k) ],
	'other_distinguishing_characteristic' => [ qw(500$q 500$r 501$r 600$q 601$q 605$q 700$q 702$q 710$q 712$q 750$q 752$q 760$q 
						    762$q) ],
	'intended_termination'		      => [ qw(110$a) ],
	'context_work'			      => [ qw(122$a 660$a 661$a) ],
	'medium_performance_musical_work'     => [ qw(128$b 500$j 501$j 700$j 702$j 750$j 752$j 760$j 762$j) ],
	'numeric_designation_musical_work'    => [ qw(500$o 501$o 600$o 601$o 605$o 700$o 702$o 710$o 712$o 750$o 752$o 760$o
	                                            762$o) ],
	'key_musical_work'		      => [ qw(128$a 500$u 501$u 600$u 601$u 605$u 700$u 702$u 710$u 712$u 750$u 752$u 760$u
	                                            762$u) ],
	'coordinates_cartographic_work'	      => [ qw(123$defgijkm) ],
	'equinox_cartographic_work'	      => [ qw(123$n) ]
    );
    return %Work_Attrs_to_cmarc;
}
sub get_expression_attrs_to_cmarc{
    my %Expression_Attrs_to_cmarc;
    %Expression_Attrs_to_cmarc = (
	    'title_expression'			  => [ qw(200$d) ],
            'form_expression'                     => [ qw(105$a 106$a 115$a 230$a) ],
            'language_expression'                 => [ qw(100$a 101$abcdefghij 200$z 225$z 500$m 501$m 505$z 510$z 512$z 513$z 514$z 515$z 516$z 517$z 521$z 522$z 523$z 524$z 525$z 526$z 527$z 530$z 531$z 534$z 535$z 536$z 540$z 541$z 544$z 545$z 546$z 547$z 548$z 552$z 553$z 600$m 601$m 605$m 700$m 702$m 710$m 712$m 750$m 752$m 760$m 762$m) ],
            'other_distinguishing_characteristic' => [ qw(500$nw 501$w 600$w 601$w 605$w 700$w 702$w 710$w 712$w 750$w 752$w 760$w 762$w) ],
            'extent_expression'                   => [ qw(115$a) ],
            'summarization_content'               => [ qw(330$a) ],
            'expected_regularity_issue'           => [ qw(110$a) ],
            'expected_frequency_issue'            => [ qw(110$a) ],
	    'type_score'			  => [ qw(208$ad 125$a) ],
            'scale'                               => [ qw(123$bch) ],
            'geodetic_grid_vertical_measurement'  => [ qw(131$abcdefghijkl 206$a) ],
            'recording_technique'                 => [ qw(124$g) ],
            'special_characteristic'              => [ qw(124$e) ],
	    'presentation_technique'		  => [ qw(124$c) ],
    );
     return %Expression_Attrs_to_cmarc;
}


sub get_manifestation_attrs_to_cmarc{
    my %Manifestation_Attrs_to_cmarc;
    %Manifestation_Attrs_to_cmarc = (
            'title_manifestation'                     => [ qw(200$acehir 225$hir 510$aehi 512$aehi 513$aehi 514$aehi 515$aehi 516$aehi 517$aehi 521$aehi 522$aehi 523$aehi 524$aehi 526$aehi 527$aehi 530$aehi 531$aehi 534$aehi 535$aehi 536$aehi 540$aehi 541$aehi 544$aehi 545$aehi 546$aehi 547$aehi 548$aehi 550$a 551$a 552$aehi 553$a 554$a 555$aehi 856$fg) ],
            'statement_responsibility'                => [ qw(200$fg 205$fg 225$f 327$fg 505$f 523$fg 700$4 702$4 710$4 712$4 750$4 752$4 760$4 762$4) ],
            'edition_issue_designation'               => [ qw(205$ab 730$a 780$a 205$d) ],
            'place_publication_distribution'          => [ qw(020$a 021$a 102$abc 210$a 521$j 522$j 523$j 524$j 525$j 526$j 527$j 530$j 531$j 534$j 535$j 536$j 540$j 541$j 544$j 545$j 546$j 547$j 548$j 730$bce 734$abcd 780$bce 784$abcd 801$a) ],
            'publisher_distributor'                   => [ qw(210$c) ],
            'date_publication_distribution'           => [ qw(100$a 210$d 210$h 762$k 760$k 752$k 750$k 712$k 710$k 702$k 700$k) ],
            'fabricator_manufacturer'                 => [ qw(210$q) ],
            'series_statement'                        => [ qw(207$az 225$ade 225$v 505$adehivx) ],
            'form_carrier'                            => [ qw(115$a 116$a 124$b 126$a 130$a 135$a 200$b 600$j 601$j 605$j 710$j 712$j) ],
            'extent_carrier'                          => [ qw(215$a) ],
            'physical_medium'                         => [ qw(115$a 115$b 115$b 116$a 121$a 130$a) ],
            'capture_mode'                            => [ qw(126$a) ],
            'dimensions_carrier'                      => [ qw(115$a 126$a 130$a 135$a 215$d) ],
            'manifestation_identifier'                => [ qw(010$az 011$ayz 013$az 014$az2 015$az 016$az 019$az2 020$bz 021$bz 022$abz 025$az 040$az 050$az 225$x 505$r 510$nr 512$nr 513$nr 514$nr 515$nr 516$nr 517$nr 521$nr567 522$nr567 523$nr567 524$nr567 525$nr567 526$nr567 527$nr567 530$nr567 531$nr567 534$nr567 535$nr567 536$nr567 540$nr567 541$nr567 544$nr567 545$nr567 546$nr567 547$567 548$567 552$567 700$567 702$567 710$567 712$567 750$567 752$567 760$567 762$567 856$u 555$rn 554$r 553$r 552$r 552$n 551$b 550$b 548$rn 547$nr) ],
            'source_acquisition_access_authorization' => [ qw(071$b 210$b 210$f 856$abnh) ],
            'terms_availability'                      => [ qw(010$bd 011$bd 013$bd 015$bd 016$bd 025$df 071$a) ],
            'access_restrictions_manifestation'       => [ qw(856$ijklmoprt) ],
	    'publication_status'		      => [ qw(555$jp 552$j 550$j 517$j 516$j 515$j 514$j 513$j 512$j 510$j) ],
            'numbering'                               => [ qw(200$pv 211$a 327$v 500$pv 510$p 512$p 513$p 514$p 515$p 516$p 517$p 521$p 522$p 523$p 524$p 525$p 526$p 527$p 600$pv 601$pv 605$pv 700$pv 702$pv 710$pv 712$pv 750$pv 752$pv 760$pv 762$pv) ],
            'playing_speed'                           => [ qw(126$a 127$a) ],
            'kind_cutting'                            => [ qw(126$a) ],
            'tape_configuration'                      => [ qw(126$a) ],
            'kind_sound'                              => [ qw(115$b 126$a 125$b) ],
            'special_reproduction_characteristic'     => [ qw(121$a 126$a 135$a) ],
            'colour'                                  => [ qw(115$a 115$b 116$a 117$a 120$a 130$a 135$a) ],
            'reduction_ratio'                         => [ qw(130$a) ],
            'polarity'                                => [ qw(115$b 130$a) ],
            'generation'                              => [ qw(130$a) ],
            'system_requirements'                     => [ qw(736$abc) ],
            'file_characteristics'                    => [ qw(135$a 856$cqs) ],
            'mode_access'                             => [ qw(856$2) ],
            'access_address'                          => [ qw(856$d) ],
            );

    return %Manifestation_Attrs_to_cmarc;
}

sub get_item_attrs_to_cmarc{
    my %Item_Attrs_to_cmarc;
    %Item_Attrs_to_cmarc = (
            'item_identifier'          => [ qw(001 009$az 090$az 500$3 501$3 600$23 601$23 605$23 606$23 607$23 680$b 681$b 686$ab 687$abcd 801$bg 805$cdekly) ],
            'fingerprint'              => [ qw(801$m 856$3 856$xz 805$np 330$u 328$u 327$a 300$au 124$ad 121$b) ],
            'provenance_item'          => [ qw(801$b) ],
            'marks_inscription'        => [ qw(805$f 124$f) ],
            'condition_item'           => [ qw(115$b 126$b) ],
            'treatment_history'        => [ qw(005 801$c 856$c) ],
	    'access_restrictions_item' => [ qw(856$w)],
            );
    return %Item_Attrs_to_cmarc;
}

sub get_person_attrs_to_cmarc{
    my %Person_Attrs_to_cmarc;
    %Person_Attrs_to_cmarc = (
            'name'              => [ qw(327$fg 523$fg 600$abgs 700$abcgs 702$abcgs 710$s 712$s 750$abcgs 752$abcgs) ],
            'dates'             => [ qw(600$f) ],
            'title'             => [ qw(600$c 700$f 702$f 750$f 752$f) ],
            'other designation' => [ qw(600$d 700$d 702$d 750$d 752$d) ],
        );

    return %Person_Attrs_to_cmarc;
}

sub get_corporate_body_attrs_to_cmarc{
    my %Corporate_Body_Attrs_to_cmarc;
    %Corporate_Body_Attrs_to_cmarc = (
            'name'		=> [ qw(601$ab 601$s 710$ab 712$ab 760$abcgs 762$abcgs) ],
            'number'            => [ qw(601$d 710$d 712$d) ],
            'place'             => [ qw(601$e 710$e 712$e) ],
            'date'              => [ qw(601$f 710$f 712$f 760$f 762$f) ],
            'other designation' => [ qw(760$d 762$d) ],
    );

    return %Corporate_Body_Attrs_to_cmarc;
}

sub get_concept_attrs_to_cmarc{
    my %Concept_Attrs_to_cmarc;
    %Concept_Attrs_to_cmarc = (
             'term' => [ qw(600$x 601$x 605$x 606$ax 607$x 610$a) ],
    );
    return %Concept_Attrs_to_cmarc;
}

sub get_object_attrs_to_cmarc{
    my %Object_Attrs_to_cmarc;
    %Object_Attrs_to_cmarc = (
            'term' => [ qw(606$a 610$a) ],
    );

    return %Object_Attrs_to_cmarc;
}

sub get_event_attrs_to_cmarc{
    my %Event_Attrs_to_cmarc;
    %Event_Attrs_to_cmarc = (
            'term' => [ qw(600$z 601$z 605$z 606$az 607$z 610$a) ],
    );

    return %Event_Attrs_to_cmarc;
}

sub get_place_attrs_to_cmarc{
    my %Place_Attrs_to_cmarc;
    %Place_Attrs_to_cmarc = (
            'term' => [ qw(600$y 601$y 605$y 606$ay 607$ay 610$a) ],
    );
    return %Place_Attrs_to_cmarc;
}

my %Entry_Attrs_to_cmarc = (
    'work'           => \&get_work_attrs_to_cmarc,
    'expression'     => \&get_expression_attrs_to_cmarc,
    'manifestation'  => \&get_manifestation_attrs_to_cmarc,
    'item'           => \&get_item_attrs_to_cmarc,
    'person'         => \&get_person_attrs_to_cmarc,
    'corporate_body' => \&get_corporate_body_attrs_to_cmarc,
    'concept'        => \&get_concept_attrs_to_cmarc,
    'object'         => \&get_object_attrs_to_cmarc,
    'event'          => \&get_event_attrs_to_cmarc,
    'place'          => \&get_place_attrs_to_cmarc
);

sub get_attrs_to_cmarc {
    my $entry = $_[0];
    return &{$Entry_Attrs_to_cmarc{$entry}};
}


1;
