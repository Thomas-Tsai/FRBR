package FRBR::CMARC;

use 5.010000;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use frbr ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
    get_work_attrs_to_cmarc get_expression_attrs_to_cmarc get_manifestation_attrs_to_cmarc get_item_attrs_to_cmarc get_person_attrs_to_cmarc get_corporate_body_attrs_to_cmarc get_concept_attrs_to_cmarc get_object_attrs_to_cmarc get_event_attrs_to_cmarc get_place_attrs_to_cmarc get_attrs_to_cmarc Entry_Attrs 
);

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&FRBR::CMARC::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}
require XSLoader;
XSLoader::load('FRBR::CMARC');

# Preloaded methods go here.
sub get_work_attrs_to_cmarc{
    my %Work_Attrs_to_cmarc;
    %Work_Attrs_to_cmarc = (
            'title_work'                          => ['500$ahi', '501$a'],
            'form_work'                           => '',
            'date_work'                           => '',
            'other_distinguishing_characteristic' => '',
            'intended_termination'                => '',
            'intended_audience'                   => '',
            'con_work'                            => '',
            'medium_performance_musical_work'     => '',
            'numeric_designation_musical_work'    => '',
            'key_musical_work'                    => '',
            'coordinates_cartographic_work'       => '',
            'equinox_cartographic_work'           => '',
            );

    return %Work_Attrs_to_cmarc;
}
sub get_expression_attrs_to_cmarc{
    my %Expression_Attrs_to_cmarc;
    %Expression_Attrs_to_cmarc = (
            'title_expression'                    => '',
            'form_expression'                     => '',
            'date_expression'                     => '',
            'language_expression'                 => '',
            'other_distinguishing_characteristic' => '',
            'extensibility_expression'            => '',
            'revisability_expression'             => '',
            'extent_expression'                   => '',
            'summarization_content'               => '',
            'con_expression'                      => '',
            'critical_response_to_expression'     => '',
            'use_restrictions_expression'         => '',
            'sequencing_pattern'                  => '',
            'expected_regularity_issue'           => '',
            'expected_frequency_issue'            => '',
            'type_score'                          => '',
            'medium_performance'                  => '',
            'scale'                               => '',
            'projection'                          => '',
            'presentation_technique'              => '',
            'representation_relief'               => '',
            'geodetic_grid_vertical_measurement'  => '',
            'recording_technique'                 => '',
            'special_characteristic'              => '',
            'technique'                           => '',
    );
     return %Expression_Attrs_to_cmarc;
}


sub get_manifestation_attrs_to_cmarc{
    my %Manifestation_Attrs_to_cmarc;
    %Manifestation_Attrs_to_cmarc = (
            'title_manifestation'                     => '',
            'statement_responsibility'                => '',
            'edition_issue_designation'               => '',
            'place_publication_distribution'          => '',
            'publisher_distributor'                   => '',
            'date_publication_distribution'           => '',
            'fabricator_manufacturer'                 => '',
            'series_statement'                        => '',
            'form_carrier'                            => '',
            'extent_carrier'                          => '',
            'physical_medium'                         => '',
            'capture_mode'                            => '',
            'dimensions_carrier'                      => '',
            'manifestation_identifier'                => '',
            'source_acquisition_access_authorization' => '',
            'terms_availability'                      => '',
            'access_restrictions_manifestation'       => '',
            'typeface'                                => '',
            'type_size'                               => '',
            'foliation'                               => '',
            'collation'                               => '',
            'publication_status'                      => '',
            'numbering'                               => '',
            'playing_speed'                           => '',
            'groove_width'                            => '',
            'kind_cutting'                            => '',
            'tape_configuration'                      => '',
            'kind_sound'                              => '',
            'special_reproduction_characteristic'     => '',
            'colour'                                  => '',
            'reduction_ratio'                         => '',
            'polarity'                                => '',
            'generation'                              => '',
            'presentation_format'                     => '',
            'system_requirements'                     => '',
            'file_characteristics'                    => '',
            'mode_access'                             => '',
            'access_address'                          => '',
            );

    return %Manifestation_Attrs_to_cmarc;
}

sub get_item_attrs_to_cmarc{
    my %Item_Attrs_to_cmarc;
    %Item_Attrs_to_cmarc = (
            'item_identifier'          => '',
            'fingerprint'              => '',
            'provenance_item'          => '',
            'marks_inscription'        => '',
            'exhibition_history'       => '',
            'condition_item'           => '',
            'treatment_history'        => '',
            'scheduled_treatment'      => '',
            'access_restrictions_item' => '',
            );
    return %Item_Attrs_to_cmarc;
}

sub get_person_attrs_to_cmarc{
    my %Person_Attrs_to_cmarc;
    %Person_Attrs_to_cmarc = (
            'name'              => '',
            'dates'             => '',
            'title'             => '',
            'other designation' => '',
        );

    return %Person_Attrs_to_cmarc;
}

sub get_corporate_body_attrs_to_cmarc{
    my %Corporate_Body_Attrs_to_cmarc;
    %Corporate_Body_Attrs_to_cmarc = (
            'name'              => '',
            'number'            => '',
            'place'             => '',
            'date'              => '',
            'other designation' => '',
    );

    return %Corporate_Body_Attrs_to_cmarc;
}

sub get_concept_attrs_to_cmarc{
    my %Concept_Attrs_to_cmarc;
    %Concept_Attrs_to_cmarc = (
             'term' => '',
    );
    return %Concept_Attrs_to_cmarc;
}

sub get_object_attrs_to_cmarc{
    my %Object_Attrs_to_cmarc;
    %Object_Attrs_to_cmarc = (
            'term' => '',
    );

    return %Object_Attrs_to_cmarc;
}

sub get_event_attrs_to_cmarc{
    my %Event_Attrs_to_cmarc;
    %Event_Attrs_to_cmarc = (
            'term' => '',
    );

    return %Event_Attrs_to_cmarc;
}

sub get_place_attrs_to_cmarc{
    my %Place_Attrs_to_cmarc;
    %Place_Attrs_to_cmarc = (
            'term' => '' 
    );
    return %Place_Attrs_to_cmarc;
}

my %Entry_Attrs = (
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

sub get_attrs{
    my $entry = $_[0];
    return &{$Entry_Attrs{$entry}};
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

FRBR::CMARC - Convert cmarc to FRBR template

=head1 SYNOPSIS

  blah blah blah

=head1 DESCRIPTION

Stub documentation for frbr, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

thomas, E<lt>thomas@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by thomas

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
