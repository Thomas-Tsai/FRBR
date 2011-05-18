package FRBR::Entry;

=head1 NAME

FRBR::Entry - Perl extension for FRBR Disply

=head1 VERSION

Version 0.0.1

=head1 SYNOPSIS

  use FRBR::Entry;

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
use 5.010000;
use strict;
use warnings;
use Carp;
use Tie::IxHash;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
    get_work_attrs get_expression_attrs get_manifestation_attrs get_item_attrs get_person_attrs get_corporate_body_attrs get_concept_attrs get_object_attrs get_event_attrs get_place_attrs get_attrs Entry_Attrs get_relation_type get_relation_type_desc
);

our $VERSION = '0.0.1'; ## update =head1 VERSION too

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&FRBR::Entry::constant not defined" if $constname eq 'constant';
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
XSLoader::load('FRBR::Entry', $VERSION);

# Preloaded methods go here.
sub get_work_attrs{
    my %Work_Attrs;
    my $t = tie(%Work_Attrs, 'Tie::IxHash');
    %Work_Attrs = (
            'title_work'                          => 'title of the work',
            'form_work'                           => 'form of work',
            'date_work'                           => 'date of work',
            'other_distinguishing_characteristic' => 'other distinguishing characteristic',
            'intended_termination'                => 'intended termination',
            'intended_audience'                   => 'intended audience',
            'context_work'                            => 'context for the work',
            'medium_performance_musical_work'     => 'medium of performance, musical work',
            'numeric_designation_musical_work'    => 'numeric designation, musical work',
            'key_musical_work'                    => 'key, musical work',
            'coordinates_cartographic_work'       => 'coordinates, cartographic work',
            'equinox_cartographic_work'           => 'equinox, cartographic work'
            );

    return %Work_Attrs;
}
sub get_expression_attrs{
    my %Expression_Attrs;
    my $t = tie(%Expression_Attrs, 'Tie::IxHash');
    %Expression_Attrs = (
            'title_expression'                    => 'title of the expression',
            'form_expression'                     => 'form of expression',
            'date_expression'                     => 'date of expression',
            'language_expression'                 => 'language of expression',
            'other_distinguishing_characteristic' => 'other distinguishing characteristic',
            'extensibility_expression'            => 'extensibility of expression',
            'revisability_expression'             => 'revisability of expression',
            'extent_expression'                   => 'extent of the expression',
            'summarization_content'               => 'summarization of content',
            'con_expression'                      => 'context for the expression',
            'critical_response_to_expression'     => 'critical response to the expression',
            'use_restrictions_expression'         => 'use restrictions on the expression',
            'sequencing_pattern'                  => 'sequencing pattern (serial)',
            'expected_regularity_issue'           => 'expected regularity of issue (serial)',
            'expected_frequency_issue'            => 'expected frequency of issue (serial)',
            'type_score'                          => 'type of score (musical notation)',
            'medium_performance'                  => 'medium of performance (musical notation or recorded sound)',
            'scale'                               => 'scale (cartographic image/object)',
            'projection'                          => 'projection (cartographic image/object)',
            'presentation_technique'              => 'presentation technique (cartographic image/object)',
            'representation_relief'               => 'representation of relief (cartographic image/object)',
            'geodetic_grid_vertical_measurement'  => 'geodetic, grid, and vertical measurement (cartographic image/object)',
            'recording_technique'                 => 'recording technique (remote sensing image)',
            'special_characteristic'              => 'special characteristic (remote sensing image)',
            'technique'                           => 'technique (graphic or projected image)',
    );
     return %Expression_Attrs;
}


sub get_manifestation_attrs{
    my %Manifestation_Attrs;
    my $t = tie(%Manifestation_Attrs, 'Tie::IxHash');
    %Manifestation_Attrs = (
            'title_manifestation'                     => 'title of the manifestation',
            'statement_responsibility'                => 'statement of responsibility',
            'edition_issue_designation'               => 'edition/issue designation',
            'place_publication_distribution'          => 'place of publication/distribution',
            'publisher_distributor'                   => 'publisher/distributor',
            'date_publication_distribution'           => 'date of publication/distribution',
            'fabricator_manufacturer'                 => 'fabricator/manufacturer',
            'series_statement'                        => 'series statement',
            'form_carrier'                            => 'form of carrier',
            'extent_carrier'                          => 'extent of the carrier',
            'physical_medium'                         => 'physical medium',
            'capture_mode'                            => 'capture mode',
            'dimensions_carrier'                      => 'dimensions of the carrier',
            'manifestation_identifier'                => 'manifestation identifier',
            'source_acquisition_access_authorization' => 'source for acquisition/access authorization',
            'terms_availability'                      => 'terms of availability',
            'access_restrictions_manifestation'       => 'access restrictions on the manifestation',
            'typeface'                                => 'typeface (printed book)',
            'type_size'                               => 'type size (printed book)',
            'foliation'                               => 'foliation (hand-printed book)',
            'collation'                               => 'collation (hand-printed book)',
            'publication_status'                      => 'publication status (serial)',
            'numbering'                               => 'numbering (serial)',
            'playing_speed'                           => 'playing speed (sound recording)',
            'groove_width'                            => 'groove width (sound recording)',
            'kind_cutting'                            => 'kind of cutting (sound recording)',
            'tape_configuration'                      => 'tape configuration (sound recording)',
            'kind_sound'                              => 'kind of sound (sound recording)',
            'special_reproduction_characteristic'     => 'special reproduction characteristic (sound recording)',
            'colour'                                  => 'colour (image)',
            'reduction_ratio'                         => 'reduction ratio (microform)',
            'polarity'                                => 'polarity (microform or visual projection)',
            'generation'                              => 'generation (microform or visual projection)',
            'presentation_format'                     => 'presentation format (visual projection)',
            'system_requirements'                     => 'system requirements (electronic resource)',
            'file_characteristics'                    => 'file characteristics (electronic resource)',
            'mode_access'                             => 'mode of access (remote access electronic resource)',
            'access_address'                          => 'access address (remote access electronic resource)'
            );

    return %Manifestation_Attrs;
}

sub get_item_attrs{
    my %Item_Attrs;
    my $t = tie(%Item_Attrs, 'Tie::IxHash');
    %Item_Attrs = (
            'item_identifier'          => 'item identifier',
            'fingerprint'              => 'fingerprint',
            'provenance_item'          => 'provenance of the item',
            'marks_inscription'        => 'marks or inscription',
            'exhibition_history'       => 'exhibition history',
            'condition_item'           => 'condition of the item',
            'treatment_history'        => 'treatment history',
            'scheduled_treatment'      => 'scheduled treatment',
            'access_restrictions_item' => 'access restrictions on the item'
            );
    return %Item_Attrs;
}

sub get_person_attrs{
    my %Person_Attrs;
    my $t = tie(%Person_Attrs, 'Tie::IxHash');
    %Person_Attrs = (
            'name'              => 'name of person',
            'dates'             => 'dates of person',
            'title'             => 'title of person',
            'other designation' => 'other designation associated with the person'
        );

    return %Person_Attrs;
}

sub get_corporate_body_attrs{
    my %Corporate_Body_Attrs;
    my $t = tie(%Corporate_Body_Attrs, 'Tie::IxHash');
    %Corporate_Body_Attrs = (
            'name'              => 'name of the corporate body',
            'number'            => 'number associated with the corporate body',
            'place'             => 'place associated with the corporate body',
            'date'              => 'date associated with the corporate body',
            'other designation' => 'other designation associated with the corporate body'
    );

    return %Corporate_Body_Attrs;
}

#relationship type
sub get_relation_type_desc {

    my %relation_type_desc;
    @{$relation_type_desc{'whole/part'}}         = ('has part', 'part of');
    @{$relation_type_desc{'reconfiguration'}}    = ('has reconfiguration', 'a reconfiguration of');
    @{$relation_type_desc{'reproduction'}}       = ('has a reproduction', 'a reproduction of ');
    @{$relation_type_desc{'alternate'}}          = ('has an alternate', 'an alternate to ');
    @{$relation_type_desc{'abridgement'}}        = ('has an abridgement', 'an abridgement of');
    @{$relation_type_desc{'revision'}}           = ('has a revision', 'a revision of ');
    @{$relation_type_desc{'translation'}}        = ('has a translation', 'a translation of ');
    @{$relation_type_desc{'arrangement'}}        = ('has an arrangement', 'an arrangement of ');
    @{$relation_type_desc{'successor'}}          = ('has a successor', 'a successor to');
    @{$relation_type_desc{'supplement'}}         = ('has a supplement', 'supplements ');
    @{$relation_type_desc{'complement'}}         = ('has a complement', 'complements');
    @{$relation_type_desc{'summary'}}            = ('has a summary', 'a summary of ');
    @{$relation_type_desc{'adaptation'}}         = ('has adaptation', 'an adaptation of');
    @{$relation_type_desc{'transformation'}}     = ('has a transformation', 'a transformation of ');
    @{$relation_type_desc{'imitation'}}          = ('has an imitation', 'an imitation of ');
    @{$relation_type_desc{'create'}}             = ('created by', 'creator of');
    @{$relation_type_desc{'realize'}}            = ('realized through', 'realization of');
    @{$relation_type_desc{'realizer'}}	      = ('realized by', 'realization of');
    @{$relation_type_desc{'produce'}}            = ('produced by', 'producer of');
    @{$relation_type_desc{'own'}}                = ('owned by', 'owner of');
    @{$relation_type_desc{'emboy'}}              = ('embodied in', 'embodiment of');
    @{$relation_type_desc{'exemplify'}}          = ('examplified by', 'example of');
    @{$relation_type_desc{'subject'}}          = ('subject by', 'subject of');
    return %relation_type_desc;
}

#relationship type with attr
sub get_relation_type {
    my %relation_type;

    my @Entry_G1 = qw(work expression manifestation item);
    my @Entry_G2 = qw(person corporate_body);
    my @Entry_G3 = qw(concept object event place);
    
    @{$relation_type{'item-item'}} = ('whole/part', 'reconfiguration', 'reproduction');
    @{$relation_type{'manifestation-menifestation'}} = ('whole/part', 'reproduction', 'alternate');
    @{$relation_type{'expression-expression_work2'}} = ('whole/part', 'abridgement', 'revision', 'translation', 'arrangement');
    @{$relation_type{'work-work'}} = ('whole/part', 'successor', 'supplement', 'complement', 'summary', 'adaptation', 'transformation', 'imitation');
    @{$relation_type{'manifestation-item'}} = ('reproduction');
    @{$relation_type{'expression-work'}} = ('successor', 'supplement', 'complement', 'summary', 'adaptation', 'transformation', 'imitation');
    @{$relation_type{'expression-expression_work'}} = ('successor', 'supplement', 'complement', 'summary', 'adaptation', 'transformation', 'imitation');
    @{$relation_type{'work-expression'}} = ('realize');
    @{$relation_type{'expression-manifestation'}} = ('emboy');
    @{$relation_type{'manifestation-item'}} = ('exemplify');

    foreach my $e1 (@Entry_G1) {
	foreach my $e2 (@Entry_G2){
	    my $type = "$e2-$e1";
	    @{$relation_type{$type}} = ('create', 'realizer', 'produce', 'own');
	}

	foreach my $e3 (@Entry_G3){
	    my $type = "$e3-$e1";
	    @{$relation_type{$type}} = ('subject');
	}
    }
    return %relation_type;
}

sub get_concept_attrs{
    my %Concept_Attrs;
    my $t = tie(%Concept_Attrs, 'Tie::IxHash');
    %Concept_Attrs = (
             'term' => 'term for the concept'
    );
    return %Concept_Attrs;
}

sub get_object_attrs{
    my %Object_Attrs;
    my $t = tie(%Object_Attrs, 'Tie::IxHash');
    %Object_Attrs = (
            'term' => 'term for the object'
    );

    return %Object_Attrs;
}

sub get_event_attrs{
    my %Event_Attrs;
    my $t = tie(%Event_Attrs, 'Tie::IxHash');
    %Event_Attrs = (
            'term' => 'term for the event'
    );

    return %Event_Attrs;
}

sub get_place_attrs{
    my %Place_Attrs;
    my $t = tie(%Place_Attrs, 'Tie::IxHash');
    %Place_Attrs = (
            'term' => 'term for the place' 
    );
    return %Place_Attrs;
}

#sub get__attrs{
#    my %_Attrs;
#    my $t = tie(%_Attrs, 'Tie::IxHash');
#
#    return %_Attrs;
#}
# Autoload methods go after =cut, and are processed by the autosplit program.

my %Entry_Attrs = (
    'work'           => \&get_work_attrs,
    'expression'     => \&get_expression_attrs,
    'manifestation'  => \&get_manifestation_attrs,
    'item'           => \&get_item_attrs,
    'person'         => \&get_person_attrs,
    'corporate_body' => \&get_corporate_body_attrs,
    'concept'        => \&get_concept_attrs,
    'object'         => \&get_object_attrs,
    'event'          => \&get_event_attrs,
    'place'          => \&get_place_attrs
);

sub get_attrs{
    my $entry = $_[0];
    return &{$Entry_Attrs{$entry}};
}

1;
__END__


